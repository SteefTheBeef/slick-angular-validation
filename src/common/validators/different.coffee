angular.module('slick-angular-validation')
.factory 'different', (valueHelper) ->
  {
    link: (scope, ctrl, argument) ->
      isModel = valueHelper.isModel(argument)

      ctrl.$validators.different = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        if ctrl.$isEmpty(modelValue) then return true

        otherValue = valueHelper.getValue(scope, isModel, argument)
        viewValue isnt otherValue

      if isModel
        return scope.$watch argument, () -> ctrl.$validate()

      return
  }