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

    type     = $placeholder.attr 'data-type'
    deviceId = $placeholder.attr 'data-device-id'

    do (type, deviceId) ->
      if type is 'toggle'
        toggleButton = new ToggleButtonView
          initial: false

        if deviceId?
          toggleButton.on 'toggled', (toggled) ->
            socket.emit 'controlled', {
              id     : deviceId
              command: if toggled then 'on' else 'off'
            }

          socket.emit 'requested', {
            id: deviceId
          }

          socket.on "changed/#{18}", (data) ->
            toggleButton.toggleForceSilent data.isOn

        $placeholder.after toggleButton.$el
        $placeholder.remove()
      else if type is 'dimmer'
        dimmer = new SliderView

        $placeholder.after dimmer.$el
        $placeholder.remove()
        