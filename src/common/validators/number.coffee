angular.module('slick-angular-validation')
.factory 'number', () ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.number = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true
        !isNaN(viewValue)
  }