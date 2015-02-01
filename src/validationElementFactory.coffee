angular.module('angular-validate.factory', ['angular-validate.rules'])

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

  getDefaultMessage = (attribute) ->
    msg = rules.getMessages()[attribute.key]
    unless msg then return ""
    msg.replace('#value', attribute.value)
    .replace('#prettyvalue', attribute.value.replace('_', ' ') if attribute.value)

  getTransformedName = (unformatedName) ->
    result = unformatedName.charAt(0).toUpperCase() + unformatedName.slice(1)
    result = result.replace(/([A-Z]+)/g, "$1").replace(/([A-Z][a-z])/g, "$1")
    result

  getNames = (elem) ->
    elementName = elem.attr('name')
    {
      elementName: elementName
      displayName: getTransformedName(elementName)
    }

  getValidationElementStart = () ->
    '<ul class="angular-validate-messages" style="display:none">'

  getListItem = (elementName, attributeKey, message) ->
    '<li class="' + elementName + '-error-' + attributeKey + '">' + message + '</li>'

  getMessage = (displayName, attribute) ->
    if attribute.message
      return displayName + ' ' + attribute.message
    else
      displayName + ' ' + getDefaultMessage(attribute)
  {
    create: (element, attrs) ->
      elem = $(element[0])
      names = getNames(elem)
      validationAttributes = getValidationAttributes(attrs.validate, attrs.validateMessages)
      validationBlock = getValidationElementStart()

      for attribute in validationAttributes
        validationBlock += getListItem(names.elementName, attribute.key, getMessage(names.displayName, attribute))

      validationBlock += '</ul>'
      elem.after(validationBlock)

      return {
        element: elem.next()
        attributes: validationAttributes
      }

  }