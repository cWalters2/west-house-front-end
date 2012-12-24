SliderView = require 'app/views/SliderView'

describe 'SliderView', ->
  it 'should have the correct initial values.', ->
    sliderView = new SliderView
    expect(sliderView.getValue()).to.be 1
    expect(sliderView._options.min).to.be 1
    expect(sliderView._options.max).to.be 100

  it 'should be able to set values.', ->
    sliderView = new SliderView
    sliderView.setValue(50)
    expect(sliderView.getValue()).to.be 50

  it 'should not overflow when setting values.', ->
    sliderView = new SliderView
    sliderView.setValue(-10)
    expect(sliderView.getValue()).to.be 1

    sliderView.setValue(200)
    expect(sliderView.getValue()).to.be 100

  it 'should be able to initialize with custom values.', ->
    sliderView = new SliderView
      height: 100
      width: 10
      min: -20
      max: 500
      initial: 40

    expect(sliderView._options.height).to.be 100
    expect(sliderView._options.width).to.be 10
    expect(sliderView._options.min).to.be -20
    expect(sliderView._options.max).to.be 500
    expect(sliderView._options.initial).to.be 40

    expect(sliderView.getValue()).to.be 40

    sliderView.setValue -40
    expect(sliderView.getValue()).to.be -20

    sliderView.setValue 600
    expect(sliderView.getValue()).to.be 500