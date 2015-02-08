angular.module('slick-angular-validation.rules')
.factory 'min', () ->
  {
    message: () -> 'cannot be less than #value'

    validate: (modelValue, min) ->
      if modelValue is "" then return true
      modelValue = parseFloat(modelValue)
      min = parseFloat(min)
      if isNaN(modelValue) or isNaN(min)
        return null
      modelValue >= min
  }