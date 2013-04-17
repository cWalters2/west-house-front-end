require 'css!styles/views/ToggleButtonView.css'

Backbone = require 'backbone'
template = require 'text!templates/views/ToggleButtonView.underscore'
helpers = require 'app/helpers'

# ## ToggleButtonView
#
# This will be the class that represents the toggle switch.
#
# TODO: unit test this.
module.exports = class ToggleButtonView extends Backbone.View
  className: 'ToggleButtonView'
  _toggled: null
  _$track: null
  _$handle: null
  _$handleText: null
  
  # ## `initialize`
  #
  # *params* `_options`: an associative array (object), with the following
  # optional properties
  # * `height`: a number representing the physical height of the button
  # * `width`: a number representing the physical width of the button
  # * `initial`: any object that represents the toggle state of the button. if
  # the value of `initial` is truthy, then the button will be toggled on.
  # Otherwise, it will be toggled off.
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

    @_updateText()

    return

  toggle: ->
    @toggleSilent()
    @trigger 'toggled', @_toggled
    return

  toggleForceSilent: (toggleOn) ->
    if toggleOn and not @isToggled()
      @toggleSilent()
    else if not toggleOn and @isToggled()
      @toggleSilent()

  toggleForce: (toggleOn) ->
    toggleForceSilent toggleOn
    @trigger 'toggled', @_toggled

  toggleSilent: ->
    @_toggled = not @_toggled
    @_animateToggle()

  _updateText: ->
    @_$handleText.html "#{if @_toggled then 'On' else 'Off'}"

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

    @_$handleText = @_$handle.find '.text'

    @_$handleText.css 'padding-top', "#{@_options.height / 4 - 6}px"

    @_animateToggle()

    @_$track.click =>
      @toggle()

    return
