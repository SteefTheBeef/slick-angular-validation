angular.module('slick-angular-validation')
.factory 'messageContainerFactory', (SlickValidation) ->
  findNameOfOtherField = (element, itemValue) ->
    form = element.parents('form').first()
    unless form.length then return false

    field = form.find('*[ng-model="' + itemValue + '"]').first()
    unless field.length then return false
    field.attr('name')

  getMessage = (item, element) ->
    if item.customMessage then return item.customMessage

    messageObj = SlickValidation.getMessage(item.key)

    if messageObj.findName
      name = findNameOfOtherField(element, item.value)
      if name then return messageObj.message.replace('#value', name)

    messageObj.message.replace('#value', item.value)
  {
    beginContainer: (formCtrlName, modelCtrlName) ->
      '<ul ng-messages="' + formCtrlName + '.'+ modelCtrlName + '.$error" class="slick-validation-messages">'

    createMessageFromItem: (item, element) ->
      '<li ng-message="' + item.key + '">' + getMessage(item, element) + '</li>'

    endContainer: () ->
      '</ul>'

    getTemplate: () ->
      '<div ng-messages="' +  + '.'+ modelCtrlName + '.$error">'
  }