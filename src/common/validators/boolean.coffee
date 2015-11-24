angular.module('slick-angular-validation')
.factory 'boolean', () ->
  {
    link: (scope, ctrl) ->
      ctrl.$validators.boolean = (modelValue, viewValue) ->
        if ctrl.$pristine then return true;
        if ctrl.$isEmpty(modelValue) then return true

        switch viewValue.toLowerCase()
          when 'true' then return true
          when 'false' then return true
          when '1' then return true
          when '0' then return true

        false

      return
  }