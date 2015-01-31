angular.module('validationService', [
  'angular-validate.stringValidation'
  'angular-validate.numberValidation'
  'angular-validate.dateValidation'
])
.factory 'validationService', ($timeout, $parse, stringValidation, numberValidation, dateValidation) ->

  class Apa
    ### string validation start ###
    validateAccepted: (modelValue) ->
      @setVadility('accepted', stringValidation.accepted(modelValue))

    validateRequired: (modelValue) ->
      @setVadility('required', stringValidation.required(modelValue))

    validateMaxLength: (modelValue, maxlength) ->
      @setVadility('maxlength',  stringValidation.maxLength(modelValue, maxlength))

    validateMinLength: (modelValue, minlength) ->
      @setVadility('minlength',  stringValidation.minLength(modelValue, minlength))

    validateEmail: (modelValue) ->
      @setVadility('email',  stringValidation.email(modelValue))

    validateAlpha: (modelValue) ->
      @setVadility('alpha',  stringValidation.alpha(modelValue))

    validateAlphaDash: (modelValue) ->
      @setVadility('alphaDash',  stringValidation.alphaDash(modelValue))

    validatePattern: (modelValue, regex) ->
      @setVadility('pattern',  stringValidation.pattern(modelValue, regex))

    validateMatch: (modelValue, otherValue) ->
      @setVadility('match',  stringValidation.match(modelValue, $parse(otherValue)(@scope)))

    ### number validation start ###
    validateNumber: (modelValue) ->
      @setVadility('number',  stringValidation.number(modelValue))

    validateMin: (modelValue, min) ->
      @setVadility('min',  numberValidation.min(modelValue, min))

    validateMax: (modelValue, max) ->
      @setVadility('min',  numberValidation.max(modelValue, max))

    ### date validation start ###
    validateDate: (modelValue) ->
      @setVadility('date',  dateValidation.date(modelValue))

    validateMaxDate: (modelValue, otherDate) ->
      @setVadility('maxdate',  stringValidation.maxDate(modelValue, otherDate))

    validateMinDate: (modelValue, otherDate) ->
      @setVadility('mindate',  stringValidation.minDate(modelValue, otherDate))

    setVadility: (name, isValid) ->
      @modelCtrl.$setValidity(name, isValid)
      unless @formCtrl[@modelCtrl.$name]
        return isValid

      @formCtrl[@modelCtrl.$name].$setValidity(name, isValid)
      @toggleValidationElement(name, isValid)

      isValid

    getModelValue: () ->
      #Allow the value to be set to false
      if @modelCtrl.$modelValue is false or @modelCtrl.$modelValue
        return $.trim(@modelCtrl.$modelValue.toString())
      else
        return ""

    execute: (specificValidationAttributes) ->
      modelValue = @getModelValue()
      for attribute in (specificValidationAttributes || @validationAttributes)
        switch attribute.key
          when 'accepted' then accepted.validate(modelValue)
          when 'email' then @validateEmail(modelValue)
          when 'required' then @validateRequired(modelValue)
          when 'maxLength' then @validateMaxLength(modelValue, attribute.value)
          when 'minLength' then @validateMinLength(modelValue, attribute.value)
          when 'alpha' then @validateAlpha(modelValue)
          when 'alphaDash' then @validateAlphaDash(modelValue)
          when 'number' then @validateNumber(modelValue)
          when 'min' then @validateMin(modelValue, attribute.value)
          when 'max' then @validateMax(modelValue, attribute.value)
          when 'number' then @validateNumber(modelValue)
          when 'pattern' then @validatePattern(modelValue, attribute.value)
          when 'maxDate' then @validateMaxDate(modelValue, attribute.value)
          when 'minDate' then @validateMinDate(modelValue, attribute.value)
          when 'match' then @validateMatch(modelValue, attribute.value)
          when 'date' then @validateDate(modelValue, attribute.value)

    toggleValidationElement: (validationKey, isValid) ->
      if @modelCtrl.$pristine then return
      unless isValid
        @validationElement.css('display', 'block')
        @toggleElement(validationKey, 'list-item')
      else
        @toggleElement(validationKey, 'none')

    toggleElement: (validationKey, display) ->
      @validationElement.children('.' + @modelCtrl.$name + '-error-' + validationKey).css('display', display)



    setWatchers: () ->
      @setMatchWatchers()

    constructor: (options) ->
      @scope = options.scope
      @formCtrl = options.formCtrl
      @modelCtrl = options.modelCtrl
      @validationAttributes = options.validationAttributes
      @validationElement = options.validationElement
      @setWatchers()

  getApa = (options) ->
    return new Apa(options)

  {
    apa: getApa
  }



