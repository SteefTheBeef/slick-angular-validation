angular.module('slick-angular-validation')
.factory 'valueHelper', ($parse) ->
  {
    isModel: (expression) ->
      if /^[0-9]+/.test(expression)
        return false

      not /^\'|\'$/.test(expression)

    getValue: (scope, isModel, val) ->
      if isModel then return $parse(val)(scope)
      val.substring(1, val.length-1)
  }