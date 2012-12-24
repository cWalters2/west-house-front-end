_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
SliderView = require 'app/views/SliderView'

module.exports.init = ->
  $ ->
    $('#main-view').append (new SliderView { min: 1, max: 4 }).$el
