angular.module('slick-angular-validation.rules')
.factory 'rules', (
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
  regex
  required
  requiredIf) ->
  {
    getMessages: () ->
      {
        accepted: accepted.message()
        alpha: alpha.message()
        alphaDash: alphaDash.message()
        alphaNumeric: alphaNumeric.message()
        boolean: boolean.message()
        inString: inString.message()
        date: date.message()
        different: different.message()
        email: email.message()
        match: match.message()
        max: max.message()
        maxDate: maxDate.message()
        maxLength: maxLength.message()
        min: min.message()
        minDate: minDate.message()
        minLength: minLength.message()
        number: number.message()
        regex: regex.message()
        required: required.message()
        requiredIf: requiredIf.message()
      }
  }




