angular.module('slick-angular-validation')
.factory 'pattern', (valueHelper) ->
  {
    link: (scope, ctrl, pattern) ->
      isModel = valueHelper.isModel(pattern)
      ctrl.$validators.pattern = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        if ctrl.$isEmpty(modelValue) then return true

        new RegExp(valueHelper.getValue(scope, isModel, pattern)).test viewValue

      if isModel
        return scope.$watch pattern, () -> ctrl.$validate()

      return
  }