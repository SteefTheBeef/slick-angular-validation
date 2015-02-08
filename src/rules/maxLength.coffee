angular.module('slick-angular-validation.rules')
.factory 'maxLength', () ->
  {
    message: () -> 'cannot exceed #value characters'

    validate: (modelValue, maxlength) ->
      if modelValue is "" then return true
      if modelValue and modelValue.length <= parseInt(maxlength)
        return true
      false
  }