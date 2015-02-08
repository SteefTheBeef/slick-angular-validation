angular.module('slick-angular-validation.rules')
.factory 'max', () ->
  {
    message: () -> 'cannot be greater than #value'

    validate: (modelValue, max) ->
      if modelValue is "" then return true
      modelValue = parseFloat(modelValue)
      max = parseFloat(max)
      if isNaN(modelValue) or isNaN(max)
        return null
      modelValue <= max
  }