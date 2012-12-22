require 'css!styles/views/SliderView.css'

template = require 'text!templates/views/SliderView.underscore'
_ = require 'underscore'
Backbone = require 'backbone'
assert = require 'assert'

module.exports = class SliderView extends Backbone.View
  className: 'SliderView'
  _isMouseDown: false
  _clickPosition: 0
  _handlePosition: 0
  _$handle: null
  _$track: null

  initialize: (@options = {}) ->
    @options.height = 200 unless @options.height
    @options.width = 50 unless @options.width
    @render()

  _setHandlePosition: (amount) ->
    assert @_$handle
    assert @_$track

    if amount < 0
      amount = 0
    else if amount > @_$track.height() - @_$handle.height()
      amount = @_$track.height() - @_$handle.height()

    @_$handle.css 'top', "#{amount}px"

  render: ->
    @$el.html _.template template, {}

    @_$track = @$el.find '.track'
    @_$handle = @_$track.find '.handle'

    @_$track.css
      width: "#{@options.width}px"
      height: "#{@options.height}px"

    @_$handle.css
      width: "#{@options.width}px"
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
