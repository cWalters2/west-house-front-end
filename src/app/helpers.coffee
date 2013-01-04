# A set of helpers to commonly used tasks.

_ = require 'underscore'

# ## `isValidNumber`
# 
# TODO: unit-test this.
#
# Determines that a given object is a valid number.
#
# * *param* `obj`: any object.
# * *returns* boolean. `true` if the `obj` is a number. `false` otherwise.
module.exports.isValidNumber = isValidNumber = (obj) ->
  return _.isNumber(obj) and not _.isNaN(obj)

# ## `endsWith`
#
# TODO: unit-test this.
#
# Determines whether a given string ends with a given suffix.
#
# * *param* `str`: string.
# * *param* `suffix`: string.
# * *returns* boolean. `true` if the `str` ends with `suffix`. `false`
# otherwise.
module.exports.endsWith = endsWith = (str, suffix) ->
  return (str.indexOf suffix, str.length - suffix.length) isnt -1