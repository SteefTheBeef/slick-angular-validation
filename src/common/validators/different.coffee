angular.module('slick-angular-validation')
.factory 'different', (valueHelper) ->
  {
    link: (scope, ctrl, otherNgModelName) ->
      isModel = valueHelper.isModel(otherNgModelName)
      ctrl.$validators.different = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        otherValue = valueHelper.getValue(scope, isModel, otherNgModelName)
        viewValue isnt otherValue

        if isModel
          return scope.$watch otherNgModelName, () -> ctrl.$validate()

      return
  }