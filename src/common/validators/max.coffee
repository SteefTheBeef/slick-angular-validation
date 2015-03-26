angular.module('slick-angular-validation')
.factory 'max', (valueHelper) ->
  {
    link: (scope, ctrl, maxValue) ->
      isModel = valueHelper.isModel(maxValue)
      ctrl.$validators.max = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        parsedViewValue = parseFloat(viewValue)
        parsedMax = parseFloat(valueHelper.getValue(scope, isModel, maxValue))

        if isNaN(parsedMax)
          throw "invalid max value"
        if isNaN(parsedViewValue) then return false

        parsedViewValue <= parsedMax

      if isModel
        return scope.$watch maxValue, () -> ctrl.$validate()
  }