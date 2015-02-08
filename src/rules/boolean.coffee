angular.module('slick-angular-validation.rules')
.factory 'boolean', () ->
  {
    message: () -> 'is not valid. Accepted input are true, false, 1, 0'

    validate: (modelValue) ->
      if modelValue is "" then return true
      switch modelValue
        when true then return true
        when false then return true
        when 1 then return true
        when 0 then return true

      if angular.isString(modelValue)
        modelValue = modelValue.toLowerCase()
        switch modelValue
          when 'true' then return true
          when 'false' then return true
          when '1' then return true
          when '0' then return true

      false
  }