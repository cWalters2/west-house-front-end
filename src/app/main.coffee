_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
SliderView = require 'app/views/SliderView'

module.exports.init = ->
  $ ->
    $('#main-view').append (new SliderView).$el
