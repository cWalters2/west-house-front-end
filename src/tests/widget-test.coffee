require 'css!styles/tests/widgets-test.css'

SliderView = require 'app/views/SliderView'
ToggleButtonView = require 'app/views/ToggleButtonView'
$ = require 'jquery'

$ ->
  $mainView = $ '#main-view'

  $parent = $ document.createElement 'div'
  $parent.addClass 'clearfix'

  createColumn = ->
    $div = $ document.createElement 'div' 
    $div.addClass 'column'
    $div.addClass 'widget-column'

    return $div

  do ->
    $div = createColumn()
    window.sliderView = sliderView = new SliderView
      width: 50
      min: 1
      max: 4
      initial: 1
    $div.append (sliderView).$el
    $parent.append $div

  do ->
    $div = createColumn()
    $div.append (new ToggleButtonView).$el
    $parent.append $div

  $mainView.append $parent
  sliderView.setInitial()
