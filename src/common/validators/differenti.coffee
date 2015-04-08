angular.module('slick-angular-validation')
.factory 'differenti', (valueHelper) ->
  {
    link: (scope, ctrl, otherNgModelName) ->
      isModel = valueHelper.isModel(otherNgModelName)
      ctrl.$validators.differenti = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        otherValue = valueHelper.getValue(scope, isModel, otherNgModelName)
        viewValue.toLowerCase() isnt otherValue.toLowerCase()

      if isModel
        return scope.$watch otherNgModelName, () -> ctrl.$validate()

      return
  }