angular.module('slick-angular-validation.rules')
.factory 'match', () ->
  {
    message: () -> 'does not match #value'

    validate: (modelValue, otherValue) ->
      if modelValue is "" then return true
      modelValue is otherValue
  }