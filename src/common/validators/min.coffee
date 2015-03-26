angular.module('slick-angular-validation')
.factory 'min', (valueHelper) ->
  {
    link: (scope, ctrl, minValue) ->
      isModel = valueHelper.isModel(minValue)
      ctrl.$validators.min = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        parsedViewValue = parseFloat(viewValue)
        parsedMin = parseFloat(valueHelper.getValue(scope, isModel, minValue))

        if isNaN(parsedMin)
          throw "invalid max value"
        if isNaN(parsedViewValue) then return false

        parsedViewValue >= parsedMin

  }