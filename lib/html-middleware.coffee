# TODO: unit-test this.

_ = require 'underscore'
path = require 'path'
fs = require 'fs'
mkdirp = require 'mkdirp'

module.exports = (options = {}) ->
  return (req, res, next) ->
    return next() if req.method isnt 'GET' and req.method isnt 'HEAD'
    pathname = url.parse(req.url).pathname
    if /\.html$/.test pathname
      htmlPath = path.join options.dest, pathname
      srcPath = path.join options.src, pathname

      error = (err) ->
        arg = if err.code is 'ENOENT' then null else err
        next arg

      compile = ->
        fs.readFile srcPath, 'utf8', (err, str) ->
          return error if err
          html = parse str
          mkdirp path.dirname(htmlPath), 0o0700, (err) ->
            return error if err
            fs.writeFile htmlPath, html, 'utf8', next

      return compile() if options.force

      fs.stat srcPath, (err, srcStats) ->
        return error err if err
        fs.stat htmlPath, (err, htmlStats) ->
          if err
            if err.code is 'ENOENT'
              compile()
            else
              next err
          else
            if srcStats.mtime > htmlStats
              compile()
            else
              next()

    else next()

parse = (html) ->
  _.template html, {
    development: process.env.NODE_ENV is 'development'
    production: process.env.NODE_ENV is 'production'
  }