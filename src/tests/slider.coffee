SliderView = require 'app/views/SliderView'

describe 'SliderView', ->
  it 'should have the correct initial values.', ->
    sliderView = new SliderView
    expect(sliderView.getValue()).to.be 2