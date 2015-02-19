angular.module('slick-angular-validation.rules')
.factory 'match', () ->
  {
    message: () -> 'must match #value'

    validate: (modelValue, otherValue) ->
      if modelValue is "" then return true
      modelValue is otherValue
  }