angular.module('slick-angular-validation')
.factory 'validateAttributeHelper', () ->
  process = (attrs) ->
    customMessages = {}
    if attrs.validateMessages
      attrs.validateMessages.split('|').forEach (message) ->
        parts = message.split(':')
        throw "Validation message attributes incorrect: " + message unless parts.length is 2
        customMessages[parts[0]] = parts[1]

    attrs.validate.split('|').map (keyAndValue) ->
      keyValue = keyAndValue.split(':')
      {
        key:  keyValue[0]
        value: keyValue[1]
        customMessage: customMessages[keyValue[0]]
      }

  {
    toObject: (attrs) ->
      process(attrs)
  }