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

Some validators takes one argument, syntax is **validator:argument**.   
The argument can either be of type ***string*** or model (any property on the scope really)
For instance, if we use validator **matches** (which is great to use for password confirmation by the way!):  

matches:'yourSecretPassword' - wrap it single quotes to match our model value against a fixed string   
matches:user.passwordConfirm - skip quoutes to compare model value to the value of another model 
matches:3ecretPassword - again match against a string, if first character is a number it will be interpreted as a string    

So by specifying a model as our argument we can have a very dynamic validation if we wish. This combined with the amount of validators available makes this package very versatile.   

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
  - valid values: **valid dates**  
  - example: `<input type="text" name="date" ng-model="data.date" validate="date">`

* **different** (case sensitive) or **differenti** (case insensitive)
  - valid values: **any value that is different from the specified value or model**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="different:'Teacher'">`
  - example: `<input type="text" name="date" ng-model="data.lastName" validate="differenti: data.firstName">`
  - More info: either compare to a string or another model.

* **email**
  - valid values: **valid email adresses**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="email">`

* **instring** (case sensitive) or **instringi** (case insensitive)
  - valid values: **value is found within the specified value or model, partial matches are fine**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="instring:'Teacher'">`
  - example: `<input type="text" name="date" ng-model="data.name" validate="instring: data.firstName">`
  - More info: either compare to a string or another model. 
  
* **match** (case sensitive) or **matchi** (case insensitive)
  - valid values: **value is found within the specified value or model, partial matches are fine**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="instring:'Teacher'">`
  - example: `<input type="text" name="date" ng-model="data.name" validate="instring: data.firstName">`
  - More info: either compare to a string or another model. 

* **max**
  - valid values: **value is less or equal to the specified max valu**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="max:3">`
  - example: `<input type="text" name="date" ng-model="data.name" validate="instring: data.firstName">`
  - More info: either compare to a string or another model. 
