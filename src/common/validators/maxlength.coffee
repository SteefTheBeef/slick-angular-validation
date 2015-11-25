angular.module('slick-angular-validation')
.factory 'maxlength', (valueHelper) ->
  {
    link: (scope, ctrl, maxlength) ->
      isModel = valueHelper.isModel(maxlength)
      ctrl.$validators.maxlength = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        rawValue = valueHelper.getValue(scope, isModel, maxlength);
        if isModel and rawValue
          maxlen = parseInt(rawValue.length);
        else
          maxlen = parseInt(rawValue);

        console.log(maxlen);
        if isNaN(maxlen) then return true
        return viewValue.length <= maxlen

      if isModel
        return scope.$watch maxlength, () -> ctrl.$validate()

      return
  }