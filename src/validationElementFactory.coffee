angular.module('slick-angular-validation.factory', ['slick-angular-validation.rules'])

.factory 'validationElementFactory', (
  $compile
  rules) ->

  getValidationAttributes = (validationAttribute, validationMessages) ->
    return [] unless validationAttribute

    message = {}
    if validationMessages
      validationMessages.split('|').forEach (validationMessage) ->
        parts = validationMessage.split(':')
        throw "Validation message attributes incorrect: " + validationMessage unless parts.length is 2
        message[parts[0]] = parts[1]

    validationAttribute.split('|').map (validationRule) ->
      keyValue = validationRule.split(':')
      result = {
        key:  keyValue[0]
        value: keyValue[1]
        message:   message[keyValue[0]]
      }

      if keyValue.length > 1
        lastParts = keyValue[1].split('=')
        result.value = lastParts[0]
        result.value2 = lastParts[1]
      result

  getDefaultMessage = (attribute, elem) ->
    currentRule = rules.get()[attribute.key]
    unless currentRule
      throw 'Validation rule:' + attribute.key + ' does not exist'

    msg = currentRule['message']
    unless msg then return ""

    unless currentRule.prettify
      return msg.replace('#value', attribute.value)

    form = elem.parents('form').first()
    unless form.length
      return msg.replace('#value', attribute.value)

    field = form.find('*[ng-model="' + attribute.value + '"]').first()
    unless field.length
      return msg.replace('#value', attribute.value)

    return msg.replace('#value', field.attr('name'))

  getTransformedName = (unformatedName) ->
    result = unformatedName.charAt(0).toUpperCase() + unformatedName.slice(1)
    result = result.replace(/([A-Z]+)/g, "$1").replace(/([A-Z][a-z])/g, " $1")
    result

  getNames = (elem) ->
    elementName = elem.attr('name')
    {
      elementName: elementName
      displayName: getTransformedName(elementName)
    }

  getValidationElementStart = () ->
    '<ul class="slick-angular-validation" style="display:none">'

  getListItem = (elementName, attributeKey, message) ->
    '<li class="' + elementName + '-error-' + attributeKey + ' text-danger">' + message + '</li>'

  getMessage = (displayName, attribute, elem) ->
    if attribute.message
      return attribute.message
    else
      displayName + ' ' + getDefaultMessage(attribute, elem)
  {
    create: (element, attrs) ->
      elem = $(element[0])

      names = getNames(elem)
      validationAttributes = getValidationAttributes(attrs.validate, attrs.validateMessages)
      validationBlock = getValidationElementStart()

      for attribute in validationAttributes
        validationBlock += getListItem(names.elementName, attribute.key, getMessage(names.displayName, attribute, elem))

      validationBlock += '</ul>'
      elem.after(validationBlock)

      ulElement = elem.next()
      return {
        element: ulElement
        children: ulElement.children()
        attributes: validationAttributes
      }

  }