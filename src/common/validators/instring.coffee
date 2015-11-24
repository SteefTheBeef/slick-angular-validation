angular.module('slick-angular-validation')
.factory 'instring', (valueHelper) ->
  {
    link: (scope, ctrl, haystack) ->
      isModel = valueHelper.isModel(haystack)
      ctrl.$validators.instring = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        if ctrl.$isEmpty(modelValue) then return true

        value = valueHelper.getValue(scope, isModel, haystack)
        value.indexOf(viewValue) isnt -1

      if isModel
        return scope.$watch haystack, () -> ctrl.$validate()

      return
  }