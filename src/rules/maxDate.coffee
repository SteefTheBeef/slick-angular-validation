angular.module('angular-validate.rules')
.factory 'maxDate', (date) ->
  {
    message: () -> 'should be less than #value'

    validate: (modelValue, otherDate) ->
      if modelValue is "" then return true
      unless date.validate(modelValue) and date.validate(otherDate)
        return true

      new Date(modelValue) < new Date(otherDate)
  }