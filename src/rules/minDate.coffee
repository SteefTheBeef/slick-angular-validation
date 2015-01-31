angular.module('angular-validate.rules')
.factory 'minDate', (date) ->
  {
    message: () -> 'should be greater than #value'

    validate: (modelValue, otherDate) ->
      if modelValue is "" then return true
      # return true if any date is invalid
      unless date.validate(modelValue) and date.validate(otherDate)
        return null

      new Date(modelValue) > new Date(otherDate)
  }