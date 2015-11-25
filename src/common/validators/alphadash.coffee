angular.module('slick-angular-validation')
.factory 'alphadash', () ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.alphadash = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        /^[a-zA-Z0-9-_]+$/i.test(viewValue)

      return
  }