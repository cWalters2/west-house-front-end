require 'css!styles/views/ToggleButtonView.css'

Backbone = require 'backbone'
template = require 'text!templates/views/BaseTrackBarView.underscore'
helpers = require 'app/helpers'

module.exports = class ToggleButtonView extends Backbone.View
  className: 'ToggleButtonView'
  _toggled: null
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

    @_toggled = !!@_options.initial

    @render()

    return

  isToggled: ->
    return @_toggled

  _trackHeight: ->
    return @_$track.height()

  _handleHeight: ->
    return @_$handle.height()

  _maxTrackTopOffset: ->
    retval = @_$track.height() - @_handleHeight()
    assert (helpers.isValidNumber retval),
    'The return value should be a number.'

    return retval

  _animateToggle: ->
    if @_toggled and @_$handle.position().top > 0
      @_$handle.css 'top', '0'
    else if not @_toggled and @_$handle.position().top < @_maxTrackTopOffset()
      @_$handle.css 'top', "#{@_maxTrackTopOffset()}px"

    return

  toggle: ->
    @_toggled = not @_toggled
    @_animateToggle()
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

    @_animateToggle()

    @_$track.click =>
      @toggle()

    return
