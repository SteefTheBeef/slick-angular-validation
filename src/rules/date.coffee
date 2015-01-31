angular.module('angular-validate.rules')
.factory 'date', () ->
  {
    message: () -> 'is not a valid date'

    validate: (modelValue) ->
      if modelValue is "" then return true
      test = new Date(modelValue)
      if Object.prototype.toString.call(test) isnt "[object Date]"
        return false

      return !isNaN(test.getTime());
  }