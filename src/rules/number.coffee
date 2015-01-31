angular.module('angular-validate.rules')
.factory 'number', () ->
  {
    message: () -> 'is not a valid number'

    validate: (modelValue) ->
      if modelValue is "" then return true
      !isNaN(modelValue)
  }