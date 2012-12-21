require 'css!styles/views/SliderView.css'

template = require 'text!templates/views/SliderView.underscore'
_ = require 'underscore'
Backbone = require 'backbone'

module.exports = class SliderView extends Backbone.View
  initialize: ->
    @render()

  render: ->
    @$el.html _.template template, {}