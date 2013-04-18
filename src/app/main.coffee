require 'css!styles/mock-up.css'

Backbone = require 'backbone'
SliderView = require 'app/views/SliderView'
ToggleButtonView = require 'app/views/ToggleButtonView'
$ = require 'jquery'
io = require 'socket.io/socket.io'

socket = io.connect "http://#{window.location.hostname}"

$ ->
  $mainView = $ '#main-view'

  for placeholder in $mainView.find '.placeholder'
    $placeholder = $ placeholder

    type = $placeholder.attr 'data-type'

    if type is 'toggle'
      toggleButton = new ToggleButtonView
        initial: false

      $placeholder.after toggleButton.$el
      $placeholder.remove()
    else if type is 'dimmer'
      dimmer = new SliderView

      $placeholder.after dimmer.$el
      $placeholder.remove()
      