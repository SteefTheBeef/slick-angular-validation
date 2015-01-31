angular.module('angular-validate.rules')
.factory 'minLength', () ->
  {
    message: () -> 'cannot be less than #value characters'

    validate: (modelValue, minlength) ->
      if modelValue is "" then return true
      if modelValue and modelValue.length >= parseInt(minlength)
        return true
      false
  }