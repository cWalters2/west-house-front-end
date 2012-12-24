require 'css!styles/views/SliderView.css'

template = require 'text!templates/views/BaseTrackBarView.underscore'
_ = require 'underscore'
Backbone = require 'backbone'
assert = require 'assert'
helpers = require 'app/helpers'

module.exports = class SliderView extends Backbone.View
  className: 'SliderView'
  _isMouseDown: false
  _clickPosition: 0
  _handlePosition: 0
  _$handle: null
  _$track: null
  _value: 0

  # TODO: document how Backbone.js' initialize method works.
  ###
  This method is called whenever a new instance of the SliderView class is
  initialized.

  @params 
    _options: an object, with the following optional properties
      - height: a number reprsenting the physical height of the slider
      - width: a number reprsenting the physical width of the slider
      - min: a number representing the minimum value that the slider can accept.
      - max: a number representing the maximum value that the slider can accept.
      - initial: the initial value to set the slider to.
  ###
  initialize: (@_options = {}) ->
    @_options = _.extend {
      height: 200
      width: 50
      min: 1
      max: 100
      initial: 1
    }, @_options

    @setValue @_options.initial

    @render()

    return

  setValue: (value) ->
    @_value = value

    if @_value < @_options.min
      @_value = @_options.min
    else if @_value > @_options.max
      @_value = @_options.max
    
    return

  getValue: ->
    return @_value

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

  render: ->
    @$el.html _.template template, {}

    @_$track = @$el.find '.track'
    @_$handle = @_$track.find '.handle'

    @_$track.css
      width: "#{@_options.width}px"
      height: "#{@_options.height}px"

    @_$handle.css
      width: "#{@_options.width}px"
      height: "50px"
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
