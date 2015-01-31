angular.module('angular-validate.rules')
.factory 'email', () ->
  {
    message: () -> 'is not a valid email'

    validate: (modelValue) ->
      if modelValue is "" then return true
      regex = /^[A-Z0-9_'%=+!`#~$*?^{}&|-]+([\.][A-Z0-9_'%=+!`#~$*?^{}&|-]+)*@[A-Z0-9-]+(\.[A-Z0-9-]+)+$/i
      if modelValue and regex.test(modelValue)
        return true
      false
  }