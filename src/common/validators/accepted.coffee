angular.module('slick-angular-validation')
.factory 'accepted', () ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.accepted = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        viewVal = viewValue.toLowerCase();
        return viewVal is 'true' or viewVal is '1'
  }