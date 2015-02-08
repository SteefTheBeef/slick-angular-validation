angular.module('slick-angular-validation.rules')
.factory 'accepted', () ->
  {
    message: () -> 'must be accepted'

    validate: (modelValue) ->
      if modelValue is "" then return true
      if modelValue is 'true' or parseInt(modelValue) is 1
        return true
      false
  }