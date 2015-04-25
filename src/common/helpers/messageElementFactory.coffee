angular.module('slick-angular-validation')
.factory 'messageContainerFactory', (SlickAngularValidation, valueHelper) ->
  getMessage = (item) ->
    if item.customMessage then return item.customMessage

    messageObj = SlickAngularValidation.getMessage(item.key)
    if valueHelper.isModel(item.value)
      messageObj.message.replace('#argument', '{{' + item.value + '}}')
    else
      messageObj.message.replace('#argument', item.value)
  {
    beginContainer: (formCtrlName, modelCtrlName) ->
      '<ul ng-messages="' + formCtrlName + '.'+ modelCtrlName + '.$error" class="slick-angular-validation-messages">'

    createMessageFromItem: (item) ->
      '<li ng-message="' + item.key + '">' + getMessage(item) + '</li>'

    endContainer: () ->
      '</ul>'
  }