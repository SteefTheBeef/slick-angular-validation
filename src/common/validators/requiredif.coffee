angular.module('slick-angular-validation')
.factory 'requiredif', (valueHelper) ->
  {
    link: (scope, ctrl, otherValue) ->
      isModel = true
      valueParts = otherValue.split('=')
      unless valueParts.length is 2
        throw 'Invalid format of requiredif: ' + otherValue

      part1IsModel = valueHelper.isModel(valueParts[1])

      ctrl.$validators.requiredif = (modelValue, viewValue) ->
        value0 = valueHelper.getValue(scope, isModel, valueParts[0])
        value1 = valueHelper.getValue(scope, part1IsModel, valueParts[1])
        if value0 is value1 and ctrl.$isEmpty(modelValue)
          return false
        true

      watchers = []
      watchers.push(scope.$watch valueParts[0], () -> ctrl.$validate())
      if part1IsModel
        watchers.push(scope.$watch valueParts[1], () -> ctrl.$validate())

      watchers
  }