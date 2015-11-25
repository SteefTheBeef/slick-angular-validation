angular.module('slick-angular-validation')
.factory 'minlength', (valueHelper) ->
  {
    link: (scope, ctrl, minlength) ->
      isModel = valueHelper.isModel(minlength)
      ctrl.$validators.minlength = (modelValue, viewValue) ->

        if ctrl.$isEmpty(modelValue) then return true

        rawValue = valueHelper.getValue(scope, isModel, minlength);
        if isModel and rawValue
          minlen = parseInt(rawValue.length);
        else
          minlen = parseInt(rawValue);

        if isNaN(minlen) then return true
        return viewValue.length >= parseInt(minlen)

      if isModel
        return scope.$watch minlength, () -> ctrl.$validate()

      return
  }