angular.module('slick-angular-validation.rules')
.factory 'alphaNumeric', () ->
  {
    message: () -> 'can only contain letters and numbers'

    validate: (modelValue) ->
      if modelValue is "" then return true
      if modelValue and /^[a-zA-Z0-9]+$/i.test(modelValue)
        return true
      false
  }