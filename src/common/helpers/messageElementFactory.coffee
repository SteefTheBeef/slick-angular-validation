angular.module('slick-angular-validation')
.factory 'messageContainerFactory', (SlickAngularValidation) ->
  getMessage = (item) ->
    if item.customMessage then return item.customMessage

    messageObj = SlickAngularValidation.getMessage(item.key)
    messageObj.message.replace('#argument', item.value)
  {
    beginContainer: (formCtrlName, modelCtrlName) ->
      '<ul ng-messages="' + formCtrlName + '.'+ modelCtrlName + '.$error" class="slick-angular-validation-messages">'

    createMessageFromItem: (item) ->
      '<li ng-message="' + item.key + '">' + getMessage(item) + '</li>'

    endContainer: () ->
      '</ul>'
  }