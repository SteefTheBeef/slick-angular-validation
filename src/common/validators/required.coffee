angular.module('slick-angular-validation')
.factory 'required', () ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.required = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        return not ctrl.$isEmpty(modelValue)

      return
  }