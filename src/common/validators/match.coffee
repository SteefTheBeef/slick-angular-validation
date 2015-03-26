angular.module('slick-angular-validation')
.factory 'match', (valueHelper) ->
  {
    link: (scope, ctrl, otherNgModelName) ->
      isModel = valueHelper.isModel(otherNgModelName)
      ctrl.$validators.match = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        otherValue = valueHelper.getValue(scope, isModel, otherNgModelName)
        viewValue is otherValue

      if isModel
        return scope.$watch otherNgModelName, () -> ctrl.$validate()

      return
  }