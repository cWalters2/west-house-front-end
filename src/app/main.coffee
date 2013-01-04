_ = require 'underscore'
$ = require 'jquery'
Backbone = require 'backbone'
SliderView = require 'app/views/SliderView'

module.exports.init = ->
  $ ->
    $mainView = $ '#main-view'
    do ->
      $div = $ document.createElement('div')
      $div.addClass 'clearfix'
      $mainView.append document.createElement('div')
    $('#main-view').append (new SliderView { min: 1, max: 4 }).$el
