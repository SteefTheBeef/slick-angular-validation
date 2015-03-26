angular.module('slick-angular-validation')
.directive 'validate', ($compile, $injector, validateAttributeHelper, messageContainerFactory) ->
  unwatchers = []
  validateCtrlNames = (formCtrl, modelCtrl) ->
    unless modelCtrl.$name then throw 'missing attribute \'name\''
    unless formCtrl.$name then throw 'missing attribute \'name\' on parent form element'


  bindValidatorsAndCreateMessageContainer = (scope, element, formCtrl, modelCtrl, attrs) ->
    messageContainerElement = messageContainerFactory.beginContainer(formCtrl.$name, modelCtrl.$name)
    arr = validateAttributeHelper.toObject(attrs)

    for item in arr
      watchers = $injector.get(item.key).link(scope, modelCtrl, item.value)
      console.log watchers
      messageContainerElement += messageContainerFactory.createMessageFromItem(item, element)

    messageContainerElement += messageContainerFactory.endContainer()
    element.after($compile(messageContainerElement)(scope))

  {
    restrict: 'A',
    require: ['ngModel', '^form'],
    link: (scope, element, attrs, ctrls) ->
      modelCtrl = ctrls[0]
      formCtrl = ctrls[1]

      validateCtrlNames(formCtrl, modelCtrl)

      bindValidatorsAndCreateMessageContainer(scope, element, formCtrl, modelCtrl, attrs)
      element.removeAttr('validate')

      scope.$on '$destroy', () ->
      #if unwatchSubmit then unwatchSubmit()
      #if unwatchModel then unwatchModel()
      #if unwatchEquality then unwatchEquality()

  }