angular.module('slick-angular-validation')
.factory 'maxlength', (valueHelper) ->
  {
    link: (scope, ctrl, maxlength) ->
      isModel = valueHelper.isModel(maxlength)
      ctrl.$validators.maxlength = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        maxlen = valueHelper.getValue(scope, isModel, maxlength)
        return viewValue.length <= parseInt(maxlen)

      if isModel
        return scope.$watch maxlength, () -> ctrl.$validate()

      return
  }