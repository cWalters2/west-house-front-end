require 'css!styles/mock-up.css'

Backbone = require 'backbone'
SliderView = require 'app/views/SliderView'
ToggleButtonView = require 'app/views/ToggleButtonView'
$ = require 'jquery'
io = require 'socket.io/socket.io'

socket = io.connect "http://#{window.location.hostname}"

$ ->
  $mainView = $ '#main-view'

  $parent = $ document.createElement 'div'
  $parent.addClass 'clearfix'
  $parent.addClass 'lights'

  class ColumnView extends Backbone.View
    className: 'column widget-column'

    initialize: (@_options) ->
      @render()

      $inner = $ document.createElement 'div'
      $inner.addClass 'inner'
      $inner.append @_options.widget.$el

      @$el.prepend $inner

    getWidget: -> @_options.widget

    render: ->
      @$el.html "<p>#{@_options.text}</p>"

  class LightsView extends Backbone.View
    className: 'lights'
    columns: []

    addColumn: (widget, text) ->
      columnView = new ColumnView
        widget: widget
        text: text

      @columns.push columnView

      @$el.append columnView.$el

    appendTo: ($el) ->
      $el.append @$el
      
      for column in @columns
        column.getWidget().setInitial?()
        column.getWidget().$el.addClass 'widget'

  parent = new LightsView

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 24
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'Loft'

  #-------------------------

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 23
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'Dining Dimmer'

  #-------------------------

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 16
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'Stairs'

  #------------------------

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 17
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'West Entry'

  #-------------------------
  
  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 18
      command: if toggled then 'on' else 'off'
    }

  socket.on 'changed/18', (data) ->
    toggleButtonView.toggleForceSilent data.isOn

  parent.addColumn toggleButtonView, 'Hallway'

  #-------------------------

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 20
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'Living Dimmer'

  #-------------------------

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 72
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'Bathroom'

  #-------------------------

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 73
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'Bathroom Mirror'

  #-------------------------

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 22
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'West Flood'

  #-------------------------

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 71
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'Garage Interior'

  #-------------------------

  toggleButtonView = new ToggleButtonView
    initial: false

  toggleButtonView.on 'toggled', (toggled) ->
    socket.emit 'controlled', {
      id: 73
      command: if toggled then 'on' else 'off'
    }

  parent.addColumn toggleButtonView, 'Dining Dimmer'

  parent.appendTo $mainView
