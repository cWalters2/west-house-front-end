# TODO: fix up this mess of require calls.
CoffeeScript = require 'coffee-script'
express = require 'express'
http = require 'http'
path = require 'path'
app = express()
server = http.createServer app
io = require('socket.io').listen server
connectCommonJsAmd = require 'connect-commonjs-amd'
watchr = require 'watchr'
emitter = new (require 'events').EventEmitter
settings = require './settings.json'
querystring = require 'querystring'

port = process.argv[2]||3000

srcFolder = path.join __dirname, 'src'
publicFolder = path.join __dirname, 'public'

app.configure ->
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use require('connect-coffee-script')({
    src: srcFolder
    dest: publicFolder
    compile: (str, options) ->
      return connectCommonJsAmd.toCommonJs(
        CoffeeScript.compile str, { bare: true }
      )
  })
  app.use require('less-middleware')({
    src: srcFolder
    dest: publicFolder
  })
  app.use express.static publicFolder
  app.use require('express-custom-mime-types')({
    mimes: {
      '.underscore': 'text/plain'
    }  
  })
  app.use app.router

deviceIds = {}

io.sockets.on 'connection', (socket) ->
  socket.on 'requested', (data) ->
    deviceIds[data.id] = true

  socket.on 'controlled', (data) ->
    requestBody = querystring.stringify
      command: if data.command is 'on' then 'on' else 'off'

    console.log data.deviceId

    request = http.request {
      host: settings.host
      port: settings.port
      path: "/devices/#{data.id}/send_command"
      method: "PUT"
      headers:
        'Content-Type': 'application/x-www-form-urlencoded'
        'Content-Length': requestBody.length.toString()
    }, (res) ->
      res.setEncoding 'utf8'
      data = ''
      res.on 'data', (chunk) ->
        data += chunk

      res.on 'end', ->
        console.log data

    console.log requestBody

    request.write requestBody
    request.end()

  setInterval ->
    for id of deviceIds
      console.log id
      request = http.request {
        host: settings.host
        port: settings.port
        path: "/devices/#{id}"
        method: "GET"
      }, (res) ->
        res.setEncoding 'utf8'

        data = ''

        res.on 'data', (chunk) ->
          data += chunk

        res.on 'end', ->
          try
            socket.emit "changed/#{id}", {
              isOn: if parseInt(JSON.parse(data).Status) then on else off
            }
          catch e
            console.log e

      request.end()
        
  , 1000

app.get '/energy-consumed.json', (req, res) ->
  res.send();

server.listen port
console.log "app listening on port #{port}."
