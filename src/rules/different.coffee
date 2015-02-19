angular.module('slick-angular-validation.rules')
.factory 'different', () ->
  {
    message: () -> 'should be different to #value'

    validate: (modelValue, otherValue) ->
      if modelValue is "" then return true
      modelValue isnt otherValue
  }