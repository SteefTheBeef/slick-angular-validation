angular.module('slick-angular-validation')
.factory 'mindate', (valueHelper, dateHelper) ->
  {
    link: (scope, ctrl, otherDate) ->
      isModel = valueHelper.isModel(otherDate)
      ctrl.$validators.mindate = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        if ctrl.$isEmpty(modelValue) then return true

        viewValueDate = new Date(viewValue)
        # if any date is invalid return true
        unless dateHelper.isValid(viewValueDate)
          return true

        oDate = new Date(valueHelper.getValue(scope, isModel, otherDate))
        unless dateHelper.isValid(viewValueDate)
          return true

        viewValueDate > oDate

      if isModel
        return scope.$watch otherDate, () -> ctrl.$validate()

      return
  }