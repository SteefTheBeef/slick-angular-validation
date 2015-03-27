Angular Validation
============

Slick form validation for AngularJS.

## Installation
* `bower install slick-angular-validation`
* Include it in your html: `<script src="path/to/dist/slick-angular-validation.js"></script>`
* Add slick-angular-validation as a dependency:  `angular.module('YourApp', ['slick-angular-validation',...]);`

## Dependencies
* AngularJS, obviously
* jQuery
* ngMessages, angular module 

## How it works
Put a validate attribute on any form element. Some examples:  
`<input type="text" name="username" ng-model="user.username" validate="required|minlength:7|alphanumeric/>`  
`<input type="text" name="age" ng-model="user.age" validate="required|number|min:18/>`

## Validators
**accepted**  
valid values: **true** or **1**   
example: `<input type="checkbox" name="terms" ng-model="data.terms" validate="accepted">`

TODO.. more to come
