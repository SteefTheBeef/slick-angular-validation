angular.module('slick-angular-validation')
.factory 'instringi', (valueHelper) ->
  {
    link: (scope, ctrl, haystack) ->
      isModel = valueHelper.isModel(haystack)
      ctrl.$validators.instringi = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        if ctrl.$isEmpty(modelValue) then return true

        value = valueHelper.getValue(scope, isModel, haystack)
        value.toLowerCase().indexOf(viewValue.toLowerCase()) isnt -1

      if isModel
        return scope.$watch haystack, () -> ctrl.$validate()

      return
  }