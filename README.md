Angular Validate
============

Writing form validation in AngularJS is boring and requires to much code which will clutter your html-templates.
Angular Validate is a lib for making form validation in AngularJS less cumbersome.

Requirements
--------
* AngularJS
* jQuery

Implemented rules so far
-------
* accepted
* alpha
* alphaDash
* alphaNumeric
* boolean
* date
* different
* inString
* email
* match
* max
* maxDate
* maxLength
* min
* minDate
* minLength
* number
* regex
* required
* requiredIf

##### accepted
Validates if 'true' or 1
```html
 <input type="checkbox" ng-model="data.terms" name="Terms & Conditions" validate="accepted">
```




