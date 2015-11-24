angular.module('slick-angular-validation')
.factory 'matchi', (valueHelper) ->
  {
    link: (scope, ctrl, otherNgModelName) ->
      isModel = valueHelper.isModel(otherNgModelName)
      ctrl.$validators.matchi = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        if ctrl.$isEmpty(modelValue) then return true

        otherValue = valueHelper.getValue(scope, isModel, otherNgModelName)
        viewValue.toLowerCase() is otherValue.toLowerCase()

      if isModel
        return scope.$watch otherNgModelName, () -> ctrl.$validate()

      return
  }