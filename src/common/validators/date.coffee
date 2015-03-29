angular.module('slick-angular-validation')
.factory 'date', (dateHelper) ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.date = (modelValue, viewValue) ->
        console.log dateHelper
        if ctrl.$isEmpty(modelValue) then return true

        test = new Date(viewValue)
        return dateHelper.isValid(test)

      return
  }