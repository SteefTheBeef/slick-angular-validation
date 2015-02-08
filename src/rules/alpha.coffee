angular.module('slick-angular-validation.rules')
.factory 'alpha', () ->
  {
    message: () -> 'can only contain alphabetic characters'

    validate: (modelValue) ->
      if modelValue is "" then return true
      /^[a-zA-Z]+$/i.test(modelValue)


  }