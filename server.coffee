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

watchr.watch
  paths: [ srcFolder, publicFolder ]
  listeners:
    change: ->
      emitter.emit 'filechange'

io.sockets.on 'connection', (socket) ->
  emitter.once 'filechange', ->
    console.log 'Fired.'
    socket.emit 'filechange', { m: 1 }

  socket.on 'controlled', (data) ->
    console.log data.command
    requestBody = querystring.stringify
      command: if data.command is 'on' then 'on' else 'off'

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

app.get '/energy-consumed.json', (req, res) ->
  res.send();

server.listen port
console.log "app listening on port #{port}."
