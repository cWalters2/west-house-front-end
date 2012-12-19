CoffeeScript = require 'coffee-script'
express = require 'express'
path = require 'path'

publicPath = path.resolve '.'
port = process.argv[2]||3000

server = express()

publicFolder = path.join __dirname, 'public'

server.configure ->
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use require('connect-coffee-script')({
    src: publicFolder
    compile: (str, options) ->
      options.bare = true
      code = CoffeeScript.compile str, options
      requireCalls = code.match /require\((\s+)?('[^'\\]*(?:\\.[^'\\]*)*'|"[^"\\]*(?:\\.[^"\\]*)*")(\s+)?\)/g
      requireCalls = requireCalls.map (str) ->
        return (str.match /('[^'\\]*(?:\\.[^'\\]*)*'|"[^"\\]*(?:\\.[^"\\]*)*")/)[0]
      requireCalls.unshift '"require"'
      code = "define([#{requireCalls.join ', '}], function () {\nvar module = { exports: {} };\n\n#{code}\n\nreturn module.exports;\n});"
      return code
  })
  server.use require('less-middleware')({
    src: publicFolder
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
