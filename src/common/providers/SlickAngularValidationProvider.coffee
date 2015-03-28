angular.module('slick-angular-validation')

.provider 'SlickAngularValidation', () ->

  @messages = {
    accepted: { message: 'must be accepted' }
    alpha: { message: 'can only contain alphabetic characters' }
    alphadash: { message: 'can only contain letters, numbers, underscores and dashes' }
    alphanumeric: { message: 'can only contain letters and numbers' }
    boolean: { message: 'is not valid. Accepted input are true, false, 1, 0' }
    date: { message: 'is not a valid date' }
    different: { message: 'should be different to #argument'}
    differenti: { message: 'should be different to #argument'}
    email: { message: 'is not a valid email' }
    instring: { message: 'cannot be found within #argument' }
    instringi: { message: 'cannot be found within #argument' }
    match: { message: 'must match #argument'}
    matchi: { message: 'must match #argument'}
    max: { message: 'cannot be greater than #argument' }
    maxdate: { message: 'should be less than #argument'}
    maxlength: { message: 'cannot exceed #argument characters' }
    min: { message: 'cannot be less than #argument' }
    mindate: { message: 'should be greater than #argument'}
    minlength: { message: 'cannot be less than #argument characters' }
    number: { message: 'is not a valid number' }
    pattern: { message: 'is not valid' }
    required: { message: 'is required' }
    requiredif: { message: 'is required' }
    url: { message: 'is not a valid url' }
  }

  @setMessage = (key, message) ->
    this.messages[key] = { message : message}

  @$get = () ->
    {
      getMessage: (key) =>
        @messages[key]
    }

  return




