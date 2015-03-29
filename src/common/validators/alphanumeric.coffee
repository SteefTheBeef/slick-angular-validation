angular.module('slick-angular-validation')
.factory 'alphanumeric', () ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.alphanumeric = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        /^[a-zA-Z0-9]+$/i.test(viewValue)

      return
  }