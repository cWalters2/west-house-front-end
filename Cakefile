wrench = require 'wrench'
helpers = require './src/app/helpers.coffee'
rimraf = require 'rimraf'
child_process = require 'child_process'
clc = require 'cli-color'

task 'do-something', 'Do something', ->
  console.log "Hello, World!"

task 'build-doc', 'Build the documentation.', ->
  # Get a list of all CoffeeScript files in `src/app`.
  coffeeFiles = wrench.readdirSyncRecursive('src/app')
    .filter((filename) -> return helpers.endsWith filename, '.coffee')
    .map((filename) -> "src/app/#{filename}")
  rimraf 'docs', (err) ->
    if err
      throw err
    docco = child_process.spawn 'docco', coffeeFiles
    docco.stdout.on 'data', (data) ->
      process.stdout.write data.toString 'utf8'
    docco.stderr.on 'data', (data) ->
      process.stdout.write clc.red data.toString 'utf8'
