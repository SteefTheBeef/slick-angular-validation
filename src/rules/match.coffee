angular.module('angular-validate.rules')
.factory 'match', () ->
  {
    message: () -> 'does not match not #value'

    validate: (modelValue, otherValue) ->
      if modelValue is "" then return true
      modelValue is otherValue
  }