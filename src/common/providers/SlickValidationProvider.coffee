angular.module('slick-angular-validation')

.provider 'SlickValidation', () ->

  @messages = {
    accepted: { message: 'must be accepted' }
    alpha: { message: 'can only contain alphabetic characters' }
    alphadash: { message: 'can only contain letters, numbers, underscores and dashes' }
    alphanumeric: { message: 'can only contain letters and numbers' }
    boolean: { message: 'is not valid. Accepted input are true, false, 1, 0' }
    date: { message: 'is not a valid date' }
    different: { message: 'should be different to #value', findName: true }
    email: { message: 'is not a valid email' }
    instring: { message: 'cannot be found within #value' }
    match: { message: 'must match #value', findName: true  }
    max: { message: 'cannot be greater than #value' }
    maxdate: { message: 'should be less than #value', findName: true }
    maxlength: { message: 'cannot exceed #value characters' }
    min: { message: 'cannot be less than #value' }
    mindate: { message: 'should be greater than #value', findName: true }
    minlength: { message: 'cannot be less than #value characters' }
    number: { message: 'is not a valid number' }
    pattern: { message: 'is not valid' }
    required: { message: 'is required' }
    requiredif: { message: 'is required' }
    url: { message: 'is not a valid url' }
  }

  @setMessage = (key, message, findName = false) ->
    this.messages[key] = { message : message, findName: findName }

  @$get = () ->
    {
      getMessage: (key) =>
        @messages[key]
    }

  return




