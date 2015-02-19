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
  requiredIf
  url) ->
  {
    get: () ->
      {
        accepted: { message: accepted.message(), prettify: false }
        alpha:{ message: alpha.message(), prettify: false }
        alphaDash: { message: alphaDash.message(), prettify: false }
        alphaNumeric: { message: alphaNumeric.message(), prettify: false }
        boolean: { message: boolean.message(), prettify: false }
        inString: { message: inString.message(), prettify: true }
        date: { message: date.message(), prettify: false }
        different: { message: different.message(), prettify: true }
        email: { message: email.message(), prettify: false }
        match: { message: match.message(), prettify: true }
        max: { message: max.message(), prettify: false }
        maxDate: { message: maxDate.message(), prettify: true }
        maxLength: { message: maxLength.message(), prettify: false }
        min: { message: min.message(), prettify: false }
        minDate: { message: minDate.message(), prettify: true }
        minLength: { message: minLength.message(), prettify: false }
        number: { message: number.message(), prettify: false }
        regex: { message: regex.message(), prettify: false }
        required: { message: required.message(), prettify: false }
        requiredIf: { message: requiredIf.message(), prettify: true }
        url: { message: url.message(), prettify: false }
      }
  }




