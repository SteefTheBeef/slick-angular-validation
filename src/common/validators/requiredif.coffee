angular.module('slick-angular-validation')
.factory 'requiredif', (valueHelper) ->
  {
    link: (scope, ctrl, otherValue) ->
      isModel = true
      watchers = []

      valueParts = otherValue.split('=')
      if valueParts.length is 2
        part1IsModel = valueHelper.isModel(valueParts[1])

        ctrl.$validators.requiredif = (modelValue, viewValue) ->
          if ctrl.$pristine then return true;
          value0 = valueHelper.getValue(scope, isModel, valueParts[0])
          value1 = valueHelper.getValue(scope, part1IsModel, valueParts[1])
          if value0 is value1 and ctrl.$isEmpty(modelValue)
            return false
          true

        if part1IsModel
          watchers.push(scope.$watch valueParts[1], () -> ctrl.$validate())

      else
        ctrl.$validators.requiredif = (modelValue, viewValue) ->
          value0 = valueHelper.getValue(scope, isModel, valueParts[0])
          if value0.length > 0 and ctrl.$isEmpty(modelValue)
            return false
          true

      watchers.push(scope.$watch valueParts[0], () -> ctrl.$validate())

      watchers
  }