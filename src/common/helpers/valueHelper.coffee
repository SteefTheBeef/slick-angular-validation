angular.module('slick-angular-validation')
.factory 'valueHelper', ($parse) ->
  startsWithDigit = (val) ->
    /^[0-9]+/.test(val)
  {
    isModel: (val) ->
      if startsWithDigit(val)
        return false

      not /^\'|\'$/.test(val)

    getValue: (scope, isModel, val) ->
      if isModel then return $parse(val)(scope)
      if startsWithDigit(val)
        return val
      val.substring(1, val.length-1)
  }