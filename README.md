Slick Angular Validation
============

Slick form validation for your AngularJS apps.

## Installation
* `bower install slick-angular-validation`
* Include it in your html: `<script src="path/to/dist/slick-angular-validation.js"></script>`
* Add slick-angular-validation as a dependency:  `angular.module('YourApp', ['slick-angular-validation',...]);`

## Dependencies
* AngularJS, obviously
* jQuery
* ngMessages, angular module 

## How it works
Native validation in angular works like this:
```
<form name="signup" novalidate>
  <input type="text" name="name" ng-model="user.name" required ng-minlength="7" 
  ng-pattern="/^[a-zA-Z0-9]+$/"/>
  <ul ng-messages="signup.name.$error">
    <li ng-message="required">field is required</li>
    <li ng-message="minlength">field is too short</li>
    <li ng-message="pattern">only alphanumeric characters allowed</li>
  </ul>
</form>
```
This is messy and writing all of this code gets tiresome pretty fast, especially if your app contains alot of fields that require validation.

With Slick Angular Validation you do this:
```
<form name="signup" novalidate>
  <input type="text" name="username" ng-model="user.name" validate="required|minlength:7|alphanumeric/> 
</form>
```

Done!  

With the pipe (|) delimeter you can combine as many validators as you like.  


## Validators
* **accepted**
  - valid values: **true or 1**   
  - example: `<input type="checkbox" name="terms" ng-model="data.terms" validate="accepted">`  

* **alpha**
  - valid values: **alphabetic characters**  
  - example: `<input type="text" name="address" ng-model="data.address" validate="alpha">`  

* **alphadash**
  - valid values: **alphabetic characters, digits, - and _**  
  - example: `<input type="text" name="zip" ng-model="data.zip" validate="alphadash">`  

* **alphanumeric**
  - valid values: **alphabetic characters and digits**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="alphanumeric">`

* **boolean**
  - valid values: **true, false, 1 and 0**  
  - example: `<input type="text" name="isGreat" ng-model="data.isGreat" validate="boolean">`

* **date**
  - valid values: **a valid date**  
  - example: `<input type="text" name="date" ng-model="data.date" validate="date">`

* **different**
  - valid values: **any value that is different from the one specified**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="different:'Teacher'">`
  - example: `<input type="text" name="date" ng-model="data.lastName" validate="different: data.firstName">`
  - More info: As is shown above, it is possible to either compare your model to a string by putting single quotes around it, or compare it to another model found in the scope
