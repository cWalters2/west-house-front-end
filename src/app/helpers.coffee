_ = require 'underscore'

module.exports =
  isValidNumber: (number) -> _.isNumber(number) and not _.isNaN(number)