angular.module('slick-angular-validation')
.factory 'email', () ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.email = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        if ctrl.$isEmpty(modelValue) then return true

        regex = /^[A-Z0-9_'%=+!`#~$*?^{}&|-]+([\.][A-Z0-9_'%=+!`#~$*?^{}&|-]+)*@[A-Z0-9-]+(\.[A-Z0-9-]+)+$/i
        regex.test(viewValue)

      return
  }