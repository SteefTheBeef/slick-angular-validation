angular.module('angular-validate.rules')
.factory 'maxLength', () ->
  {
    message: () -> 'cannot exceed #value characters'

    validate: (modelValue, maxlength) ->
      if modelValue is "" then return true
      if modelValue and modelValue.length <= parseInt(maxlength)
        return true
      false
  }