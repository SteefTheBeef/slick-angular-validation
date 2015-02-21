angular.module('slick-angular-validation', ['slick-angular-validation.rules', 'slick-angular-validation.factory'])

.directive 'validate', (
  $timeout
  $parse
  validationElementFactory
  accepted
  alpha
  alphaDash
  alphaNumeric
  boolean
  inString
  date
  different
  email
  match
  max
  maxDate
  maxLength
  min
  minDate
  minLength
  number
  pattern
  required
  requiredIf
  url) ->

  {
    restrict: 'A',
    require: ['ngModel', '^form'],
    compile: (element, attrs) ->
      unless attrs.name
        throw 'missing attribute name'

      validation = validationElementFactory.create(element, attrs)

      return (scope, element, attrs, ctrls) ->
        modelCtrl = ctrls[0]
        formCtrl = ctrls[1]



        getValidateOn = () ->
          getElementValidateOn = () ->
            unless attrs.validateOn
              return 'empty'
            switch attrs.validateOn
              when 'blur' then return 'blur'
              when 'change' then return 'change'
            'empty'
          getIt = (valOn) ->
            unless valOn then return 'empty'
            switch valOn
              when 'blur' then return 'blur'
              when 'change' then return 'change'
            'empty'

          setFormCtrlValidateOn = () ->
            form = element.parents('form').first()
            validateOn = form.attr('validate-on')
            formCtrl.validateOn = getIt(validateOn)

          # first check if element has any validate on attribute
          elementValidation = getElementValidateOn()
          unless elementValidation is 'empty'
            return elementValidation

          # if not, then check the form/formCtrl
          unless formCtrl.validateOn
            setFormCtrlValidateOn()
          formCtrl.validateOn

        $timeout () ->
          watchEquality = () ->
            unwatchEquality = null
            for attribute in validation.attributes
              switch attribute.key
                when 'match', 'different', 'minDate', 'maxDate', 'requiredIf'
                  unwatchEquality = scope.$watch attribute.value, () =>
                    $timeout () =>
                      modelCtrl.$setDirty()
                      run([attribute])
            unwatchEquality

          watchSubmit = () ->
            unless formCtrl and formCtrl.$name then return
            scope.$watch formCtrl.$name + '.$submitted', (value) ->
              if value is true
                modelCtrl.$setDirty()
                run()

          watchModel = () ->
            validationCount = 0
            unwatchModel = scope.$watch attrs.ngModel, () ->
              if validationCount > 0
                run()
              validationCount++
            unwatchModel

          toggleItem = (validationKey, display) ->
            validation.element.children('.' + modelCtrl.$name + '-error-' + validationKey).css('display', display)

          toggleElement = (validationKey, isValid) ->
            if modelCtrl.$pristine then return
            unless isValid
              validation.element.css('display', 'block')
              toggleItem(validationKey, 'list-item')
            else
              toggleItem(validationKey, 'none')
              unless validation.children().filter(":visible").length
                validation.element.css('display', 'none')

          setIsValid = (key, isValid) ->
            modelCtrl.$setValidity(key, isValid)

          getModelValue = () ->
            #Allow the value to be set to false
            if modelCtrl.$modelValue is false or modelCtrl.$modelValue
              return $.trim(modelCtrl.$modelValue.toString())
            return ""

          getParsedValue = (value) ->
            val = $parse(value)(scope)
            unless val then return value
            val

          run = (specificValidationAttributes) ->
            modelValue = getModelValue()
            for attribute in (specificValidationAttributes || validation.attributes)
              result = null
              switch attribute.key
                when 'accepted' then result = accepted.validate(modelValue)
                when 'alpha' then result = alpha.validate(modelValue)
                when 'alphaDash' then result = alphaDash.validate(modelValue)
                when 'alphaNumeric' then result = alphaNumeric.validate(modelValue)
                when 'boolean' then result = boolean.validate(modelValue)
                when 'inString' then result = inString.validate(modelValue, $parse(attribute.value)(scope))
                when 'date' then result = date.validate(modelValue, attribute.value)
                when 'different' then result = different.validate(modelValue, $parse(attribute.value)(scope))
                when 'email' then result = email.validate(modelValue)
                when 'match' then result = match.validate(modelValue, $parse(attribute.value)(scope))
                when 'max' then result = max.validate(modelValue, attribute.value)
                when 'maxLength' then result = maxLength.validate(modelValue, attribute.value)
                when 'min' then result = min.validate(modelValue, attribute.value)
                when 'maxDate' then result = maxDate.validate(modelValue, $parse(attribute.value)(scope))
                when 'minDate' then result = minDate.validate(modelValue, $parse(attribute.value)(scope))
                when 'minLength' then result = minLength.validate(modelValue, attribute.value)
                when 'number' then result = number.validate(modelValue)
                when 'pattern' then result = pattern.validate(modelValue, attribute.value)
                when 'required' then result = required.validate(modelValue)
                when 'requiredIf'
                  result = requiredIf.validate(modelValue, $parse(attribute.value)(scope), getParsedValue(attribute.value2))
                when 'url' then result = url.validate(modelValue)

              setIsValid(attribute.key, result)
              toggleElement(attribute.key, result)



          watchSubmit()
          validateOn = getValidateOn()
          if validateOn isnt 'blur'
            watchModel()
            watchEquality()

          element.blur () -> run()

          if attrs.type and (attrs.type is 'checkbox' or attrs.type is 'radio')
            element.change () -> run()

          run()
  }