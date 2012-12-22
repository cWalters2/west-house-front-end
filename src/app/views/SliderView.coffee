require 'css!styles/views/SliderView.css'

template = require 'text!templates/views/SliderView.underscore'
_ = require 'underscore'
Backbone = require 'backbone'

module.exports = class SliderView extends Backbone.View
  className: 'SliderView'
  _isMouseDown: false
  _clickPosition: 0

  initialize: (@options = {}) ->
    @options.height = 200 unless @options.height
    @options.width = 50 unless @options.width
    @render()

  render: ->
    @$el.html _.template template, {}

    $track = @$el.find '.track'

    $track.css
      width: "#{@options.width}px"
      height: "#{@options.height}px"


    $handle = $track.find '.handle'

    $handle.css
      width: "#{@options.width}px"
      height: "50px"

    self = this
    
    $handle.mousedown (e) ->
      $this = $ this
      self._isMouseDown = true
      self._clickPosition = e.pageY - $this.offset().top
      console.log "Mouse is down."

    $document = $ document
    
    mouseupCb = =>
      @_isMouseDown = false

    $handle.mouseup mouseupCb
    $document.mouseup mouseupCb

    $document.mousemove (e) ->
      $this = $ this
      if self._isMouseDown
        $handle.css 'top', "#{e.pageY - self._clickPosition}px"
