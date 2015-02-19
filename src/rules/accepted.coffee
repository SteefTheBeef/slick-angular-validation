angular.module('slick-angular-validation.rules')
.factory 'accepted', () ->
  {
    message: () -> 'must be accepted'

    validate: (modelValue) ->
      if modelValue is "" then return true

      modelValue = modelValue.toLowerCase();
      if modelValue is 'true' or modelValue is '1'
        return true
      false
  }