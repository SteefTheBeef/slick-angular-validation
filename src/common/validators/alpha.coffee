angular.module('slick-angular-validation')
.factory 'alpha', () ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.alpha = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        /^[a-zA-Z]+$/i.test(viewValue)
  }