angular.module('slick-angular-validation.rules')
.factory 'required', () ->
  {
    message: () -> 'is required'

    validate: (modelValue) ->
      if modelValue is undefined or modelValue is null or modelValue is ''
        return false
      true
  }