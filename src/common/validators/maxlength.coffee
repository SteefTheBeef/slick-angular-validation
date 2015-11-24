angular.module('slick-angular-validation')
.factory 'maxlength', (valueHelper) ->
  {
    link: (scope, ctrl, maxlength) ->
      isModel = valueHelper.isModel(maxlength)
      ctrl.$validators.maxlength = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        if ctrl.$isEmpty(modelValue) then return true

        maxlen = parseInt(valueHelper.getValue(scope, isModel, maxlength))
        if isNaN(maxlen) then return true
        return viewValue.length <= maxlen

      if isModel
        return scope.$watch maxlength, () -> ctrl.$validate()

      return
  }