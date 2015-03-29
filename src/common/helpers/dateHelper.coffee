angular.module('slick-angular-validation')
.factory 'dateHelper', () ->
  {
    isValid: (date) ->
      if Object.prototype.toString.call(date) isnt "[object Date]"
        return false

      not isNaN(date.getTime())
  }