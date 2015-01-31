angular.module('angular-validate.rules')
.factory 'regex', () ->
  {
    message: () -> 'is not valid'

    validate: (modelValue, regex) ->
      if modelValue is "" then return true
      new RegExp(regex).test modelValue
  }