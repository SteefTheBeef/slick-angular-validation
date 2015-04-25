class ValidatorTestHelper
  getMockedDateHelper: () ->
    {
      isValid: (date) ->
        if Object.prototype.toString.call(date) isnt "[object Date]"
          return false

        not isNaN(date.getTime())
    }

  getMockedValueHelper: () =>
    startsWithDigit = (val) ->
      /^[0-9]+/.test(val)
    {
      isModel: (val) ->
        if startsWithDigit(val)
          return false

        if /^\'|\'$/.test(val)
          return false

        true

      getValue: (scope, isModel, val) =>
        if isModel then return @$parse(val)(scope)
        if startsWithDigit(val)
          return val
        val.substring(1, val.length-1)
    }

  getMockedModelCtrl: () ->
    {
      $isEmpty: (value) ->
        angular.isUndefined(value) or value is '' || value is null || value isnt value

      $validators: {}
    }

  beforeEach: (validator, factoryMocks = []) ->
    @validatorName = validator

    beforeEach () =>
      module 'ngMessages'
      module 'slick-angular-validation', ($provide) =>
        for fm in factoryMocks
          $provide.factory fm.key, fm.fn
        return

      @inject(validator)

  inject: (validator) ->
      inject ($injector) =>
        @$rootScope =  $injector.get('$rootScope')
        @$parse = $injector.get('$parse')
        @validator = $injector.get(validator)

  link: (argument) ->
    @scope = @$rootScope.$new()
    @validator.link(@scope, @modelCtrl, argument)

  validate: (viewValue) ->
    @modelCtrl.$validators[@validatorName](viewValue, viewValue)

  constructor: () ->
    @modelCtrl = @getMockedModelCtrl()

