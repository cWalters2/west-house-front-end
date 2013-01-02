require 'css!styles/views/SliderView.css'

template = require 'text!templates/views/BaseTrackBarView.underscore'
_ = require 'underscore'
Backbone = require 'backbone'
assert = require 'assert'
helpers = require 'app/helpers'

# ## SliderView
#
# TODO: unit-test this.
#
# This class that will represent a slider/track-bar.
#
# * *event* `slidechange`. Called when the user changes the value through the
# slider, or when the value is changed through `setValue`.
module.exports = class SliderView extends Backbone.View
  className: 'SliderView'
  _isMouseDown: false
  _clickPosition: 0
  _handlePosition: 0
  _$handle: null
  _$track: null
  _value: 0

  # TODO: document how Backbone.js' initialize method works.
  
  # ## `initialize` 
  #
  # This method is called whenever a new instance of the SliderView class is
  # initialized.
  #
  # It will render the slider, by calling the this class' `render` method.
  #
  # * *param* `_options`: associative array (object). It has the following
  # options:
  #   * `height`: a number reprsenting the physical height of the slider.
  #   * `width`: a number reprsenting the physical width of the slider.
  #   * `min:` a number representing the minimum value that the slider can
  #   accept.
  #   * `max`: a number representing the maximum value that the slider can
  #   accept.
  #   * `initial`: the initial value to set the slider to.
  # * *see also* `render`
  initialize: (@_options = {}) ->
    @_options = _.extend {
      height: 200
      width: 50
      min: 1
      max: 100
      initial: 1
    }, @_options

    @render()

    @setValue @_options.initial

    return

  # ## `setValue` 
  #
  # Sets the slider's value. If the value isn't within the defined `min` and `max`
  # then a value close to that will be set.
  #
  # * *param* `value`: the value to set the slider to.
  # * *see also* `initialize`
  setValue: (value) ->
    @_value = value

    if @_value < @_options.min
      @_value = @_options.min
    else if @_value > @_options.max
      @_value = @_options.max
    
    @_setHandlePositionByValue @_value

    @.trigger 'slidechange'

  # ## `getValue`
  #
  # Get the current value that the silder has been set to.
  #
  # * *returns* a number.
  getValue: ->
    return @_value

  # ## `render`
  #
  # 
  render: ->
    @$el.html _.template template, {}

    @_$track = @$el.find '.track'
    @_$handle = @_$track.find '.handle'

    @_$track.css
      width: "#{@_options.width}px"
      height: "#{@_options.height}px"

    @_$handle.css
      width: "#{@_options.width}px"
      top: "#{@_handlePosition}px"

    self = this
    
    @_$handle.mousedown (e) ->
      $this = $ this
      self._isMouseDown = true
      self._clickPosition = e.pageY - $this.offset().top

    $document = $ document
    
    mouseupCb = =>
      @_isMouseDown = false

    @_$handle.mouseup mouseupCb
    $document.mouseup mouseupCb

    $document.mousemove (e) ->
      $this = $ this
      if self._isMouseDown
        self._setHandlePosition e.pageY - self._clickPosition
        self.trigger 'slidechange'

  _getTrackHeight: ->
    return @_$track.height()

  _getHandleHeight: ->
    return @_$handle.height()

  _synthesizeHandlePosition: (amount) ->
    if not helpers.isValidNumber amount
      throw new Error "Amount should be anumber"

    height = @_getTrackHeight() - @_getHandleHeight()
    assert (helpers.isValidNumber height), "The height should be a number."

    max = @_options.max - @_options.min
    assert (helpers.isValidNumber max), "The max should be a number"

    percentage = amount / height

    handlePos = Math.round(percentage * max) / max

    retval = Math.round(handlePos * height)

    return retval

  _getHandlePosition: -> @_$handle.position().top

  _getValueForHandlePosition: ->
    handlePosition = @_getHandlePosition()
    assert (helpers.isValidNumber handlePosition),
    "Handle position should be a number"

    height = @_getTrackHeight() - @_getHandleHeight()
    assert (helpers.isValidNumber height), "The height should be a number"

    percentage = handlePosition / height

    max = @_options.max - @_options.min
    assert (helpers.isValidNumber max), "The max should be a number"

    percentage = handlePosition / height

    retval = (Math.round max * percentage) + @_options.min
    return retval

  _setHandlePositionByValue: (value) ->
    assert @_$handle, "Handle should be defined."
    assert @_$track, "Track should be defined."

    if value < @_options.min
      #@_setHandlePosition 0
      value = @_options.min
    else if value > @_options.max
      #@_setHandlePosition @_getTrackHeight()
      value = @_options.max

    max = @_options.max - @_options.min
    assert (helpers.isValidNumber max), "Max should be a number."

    height = @_$handle.height() - @_$track.height()
    assert (helpers.isValidNumber height), "The height should be a number."

    newValue = value + @_options.min
    percentage = newValue / max

    @_setHandlePosition Math.round percentage * height

  _setHandlePosition: (amount) ->
    assert @_$handle
    assert @_$track

    if amount < 0
      amount = 0
    else if amount > @_getTrackHeight() - @_getHandleHeight()
      amount = @_getTrackHeight() - @_getHandleHeight()

    assert (helpers.isValidNumber amount), "The amount should be a number."

    amount = @_synthesizeHandlePosition amount

    assert (helpers.isValidNumber amount), "The amount should be a number."

    @_$handle.css 'top', "#{amount}px"
