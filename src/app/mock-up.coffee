require 'css!styles/mock-up.css'

Backbone = require 'backbone'
SliderView = require 'app/views/SliderView'
ToggleButtonView = require 'app/views/ToggleButtonView'
$ = require 'jquery'

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

  parent.addColumn new SliderView({
    min: 1
    max: 4
    initial: 1
  }), 'Kitchen'

  parent.addColumn new SliderView(initial: 26), 'Dining Area'

  parent.addColumn new SliderView({
    min: 0
    initial: 50
  }), 'Lounge'

  parent.addColumn new SliderView({  
    min: 0
    initial: 75
  }), 'Sleeping Area'

  parent.addColumn new ToggleButtonView({initial: true}), 'Landscape'

  parent.appendTo $mainView
