require 'css!styles/views/ToggleButtonView.css'

Backbone = require 'backbone'
template = require 'text!templates/views/BaseTrackBarView.underscore'

module.exports = class ToggleButtonView extends Backbone.View
  className: 'ToggleButtonView'
  toggled: null
  _$track: null
  _$handle: null

  ###
  @params
    _options: an object, with the following optional properties
      - height: a number representing the physical height of the button
      - width: a number representing the physical width of the button
      - initial: any object that represents the toggle state of the button.
        if the value of `initial` is truthy, then the button will be toggled
        on. Otherwise, it will be toggled off.
  ###
  initialize: (@_options = {}) ->
    @_options = _.extend {
      height: 200
      width: 50
      initial: false
    }, @_options

    @toggled = !!@_options.initial

    @render()

    return

  render: ->
    @$el.html _.template template, {}

    @_$track = @$el.find '.track'
    @_$handle = @_$track.find '.handle'

    @_$track.css
      width: "#{@_options.width}px"
      height: "#{@_options.height}px"

    @_$handle.css
      width: "#{@_options.width}px"
      height: "#{@_options.height / 2}px"
