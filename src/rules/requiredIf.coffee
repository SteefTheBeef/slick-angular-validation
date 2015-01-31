angular.module('angular-validate.rules')
.factory 'requiredIf', () ->
  {
    message: () -> 'is required'

    validate: (modelValue, otherValue, value2) ->
      if otherValue is value2.toString() and modelValue.length <= 0
        return false
      true
  }