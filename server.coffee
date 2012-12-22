CoffeeScript = require 'coffee-script'
express = require 'express'
path = require 'path'
connectCommonJsAmd = require 'connect-commonjs-amd'

publicPath = path.resolve '.'
port = process.argv[2]||3000

server = express()

srcFolder = path.join __dirname, 'src'
publicFolder = path.join __dirname, 'public'

server.configure ->
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use require('connect-coffee-script')({
    src: srcFolder
    dest: publicFolder
    compile: (str, options) ->
      return connectCommonJsAmd.toCommonJs(
        CoffeeScript.compile str, { bare: true }
      )
  })
  server.use require('less-middleware')({
    src: srcFolder
    dest: publicFolder
  })
  server.use express.static publicFolder
  server.use require('express-custom-mime-types')({
    mimes: {
      '.underscore': 'text/plain'
    }  
  })
  server.use express.errorHandler
    dumpException: true
    showStack: true
  server.use server.router

server.listen port
console.log "Server listening on port #{port}."
