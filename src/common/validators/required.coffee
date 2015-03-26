angular.module('slick-angular-validation')
.factory 'required', () ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.required = (modelValue, viewValue) ->
        return not ctrl.$isEmpty(modelValue)

      return
  }