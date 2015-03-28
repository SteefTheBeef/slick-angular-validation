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

##
Native validation in angular works like this:
```
<form name="signup" novalidate>
  <input type="text" name="name" ng-model="user.name" required ng-minlength="7" 
  ng-pattern="/^[a-zA-Z0-9]+$/"/>
  <ul ng-messages="signup.username.$error">
    <li ng-message="required">field is required</li>
    <li ng-message="minlength">field is too short</li>
    <li ng-message="pattern">only alphanumeric characters allowed</li>
  </ul>
</form>
```
Writing this gets messy and tiresome pretty fast, especially if your form contains alot of fields that require validation.

With slick angular validation you do this:
```
<form name="signup" novalidate>
  <input type="text" name="username" ng-model="user.name" validate="required|minlength:7|alphanumeric/> 
</form>
```

Done!  

With the | (pipe) delimeter you can combine as many validators as you like.  


## Validators
**accepted**  
valid values: **true** or **1**   
example: `<input type="checkbox" name="terms" ng-model="data.terms" validate="accepted">`

TODO.. more to come
