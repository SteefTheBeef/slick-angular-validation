angular.module('angular-validate.rules')
.factory 'alphaDash', () ->
  {
    message: () -> 'can only contain letters, numbers, underscores and dashes'

    validate: (modelValue) ->
      if modelValue is "" then return true
      if modelValue and /^[a-zA-Z0-9-_]+$/i.test(modelValue)
        return true
      false
  }