angular.module('slick-angular-validation.rules')
.factory 'pattern', () ->
  {
    message: () -> 'is not valid'

    validate: (modelValue, regex) ->
      if modelValue is "" then return true
      new RegExp(regex).test modelValue
  }