angular.module('angular-validate.rules')
.factory 'inString', () ->
  {
    message: () -> 'cannot be less than #value'

    validate: (modelValue, haystack) ->
      if modelValue is "" then return true
      if angular.isString(haystack) and angular.isString(modelValue)
        haystack = haystack.toLowerCase()
        return haystack.indexOf(modelValue.toLowerCase()) isnt -1
      false

  }