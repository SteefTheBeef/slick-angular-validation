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
```html
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
```html
<form name="signup" novalidate>
  <input type="text" name="username" ng-model="user.name" validate="required|minlength:7|alphanumeric"/> 
</form>
```

Done!  

With the pipe (|) delimeter you can combine as many validators as you like.

## Error Messages
Each validator comes with a default error message.   
If you wish to change it you can do this in two ways:  

#### Per field
Use attribute **validate-messages**:
```html 
<input ... validate="alphanumeric" validate-messages="alphanumeric:Only letters and numbers!"/>
```  

#### On a global scale
Inject ***SlickAngularValidationProvider*** into the config part of your app:
```JavaScript
app.config(["SlickAngularValidationProvider", function (SlickAngularValidationProvider) {
  SlickAngularValidationProvider.setMessage('alphanumeric', 'Only letters and numbers!');
  // note that #argument is replaced by the value of the argument when used
  SlickAngularValidationProvider.setMessage('minlength', 'minimum length of field is #argument');
}])
```

## Validators

Some validators takes one argument, syntax is **validator:argument**.   
The argument can either be of type ***string*** or ***model*** (any property on the scope really)  

For instance, if we use validator **match** (which is great to use for password confirmation by the way!):  
match:'yourSecretPassword' - wrap it single quotes to match our model value against a fixed string   
match:user.passwordConfirm - skip quoutes to compare model value to the value of another model 
match:3ecretPassword - again match against a string, if first character is a number it will be interpreted as a string    

So by specifying a model as our argument we can have a very dynamic validation if we wish. This combined with the large number of available validators makes this package very versatile.   

#### Prebuilt validators 

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
  - example: `<input type="text" name="date" ng-model="data.name" validate="instring:data.firstName">`
  - More info: either compare to a string or another model. 
  
* **match** (case sensitive) or **matchi** (case insensitive)
  - valid values: **value is found within the specified value or model, partial matches are fine**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="instring:'Teacher'">`
  - example: `<input type="text" name="date" ng-model="data.name" validate="instring:data.firstName">`
  - More info: either compare to a string or another model. 

* **max**
  - valid values: **value is less or equal to the specified max value**  
  - example: `<input type="text" name="age" ng-model="data.age" validate="max:17">`
  - example: `<input type="text" name="age" ng-model="data.age" validate="max:data.maximumAge">`
  - More info: either compare to a string or another model.

* **maxdate** (great to use in conjuction with mindate)
  - valid values: **date precedes the specified max date**  
  - example: `<input type="date" name="sDate" ng-model="data.sDate" validate="maxdate:2015-02-03">`
  - example: `<input type="date" name="sDate" ng-model="data.sDate" validate="maxdate:data.endDate">`
  - More info: either compare to a string or another model.

* **maxlength** 
  - valid values: **character count of value is less or equal to the specified max length**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="maxlength:20">`
  - example: `<input type="text" name="name" ng-model="data.name" validate="maxdate:data.maxlength">`
  - More info: either compare to a string or another model.

* **min**
  - valid values: **value is greater or equal to the specified min value**  
  - example: `<input type="text" name="age" ng-model="data.age" validate="min:18">`
  - example: `<input type="text" name="age" ng-model="data.age" validate="max:data.minimumAge">`
  - More info: either compare to a string or another model.

* **mindate** (great to use in conjuction with maxdate)
  - valid values: **date should come after the specified min date**  
  - example: `<input type="date" name="eDate" ng-model="data.eDate" validate="mindate:2015-02-03">`
  - example: `<input type="date" name="eDate" ng-model="data.eDate" validate="mindate:data.startDate">`
  - More info: either compare to a string or another model.

* **minlength** 
  - valid values: **character count of value is greater or equal to the specified min length**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="minlength:20">`
  - example: `<input type="text" name="name" ng-model="data.name" validate="minlength:data.minlength">`
  - More info: either compare to a string or another model.

* **number** 
  - valid values: **any valid number**  
  - example: `<input type="text" name="num" ng-model="data.num" validate="number">`

* **pattern** 
  - valid values: **anything that the matches the pattern**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="pattern:'/^[a-zA-Z0-9]+$/'"/>">`
  - example: `<input type="text" name="name" ng-model="data.name" validate="pattern:allowedPattern">`
  - More info: either compare to a string or another model.

* **required** 
  - valid values: **anything that is not empty!**  
  - example: `<input type="text" name="name" ng-model="data.name" validate="required">`

* **requiredif** 
  - valid values: **anything that is not empty, when the if statment is fulfilled**  
  - example: `<input type="text" name="lastName" ng-model="data.lastName" validate="requiredif:data.firstName>`
  - example: `<input type="text" name="lastName" ng-model="data.lastName" validate="requiredif:data.firstName='Eva'">`
  - example: `<input type="text" name="lastName" ng-model="data.lastName" validate="requiredif:data.firstname=otherUser.firstName">`
  - More info: either compare to a string or another model.
  
* **url** 
  - valid values: **valid urls**  
  - example: `<input type="text" name="website" ng-model="data.website" validate="url">`

## Creating custom validators

To create and use your own custom validator is simple. Just create a service with the name you want.
For a simple validator without argument it should follow this look:
```JavaScript
angular.module('yourModule').factory('customvalidator', function () {
  return {
    link: function (scope, ctrl) {
      ctrl.$validators.customvalidator = function (modelValue, viewValue) {
        // if value is empty it should pass validation
        // we use validator 'required' to check for empty values
        if ctrl.$isEmpty(modelValue) {
          return true
        }
        
        .... your custom validation code ...
        
        // all is fine
        return true
      }
    }
  };
});
```

**alpha validator example:**
```JavaScript
angular.module('slick-angular-validation').factory('alpha', function () {
  return {
    link: function (scope, ctrl) {
      ctrl.$validators.alpha = function (modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        
        return /^[a-zA-Z]+$/i.test(viewValue);
      }
    }
  };
});
```
for more advanced validators that takes an argument, take a look at the match validator:
```JavaScript
// valueHelper will help determine the value of the argument
angular.module('slick-angular-validation').factory('match', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, argument) {
      var isModel;
      isModel = valueHelper.isModel(argument);
      
      ctrl.$validators.match = function(modelValue, viewValue) {
        var otherValue;
        
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }

        otherValue = valueHelper.getValue(scope, isModel, argument);
        return viewValue === otherValue;
      };
      
      // if the argument is another model then we should watch it for changes, 
      // do not forget to return the watcher! 
      if (isModel) {
        return scope.$watch(argument, function() {
          ctrl.$validate();
        });
      }
    }
  };
}]);
```

You should also set default error message for your custom validator:
```JavaScript
app.config(["SlickAngularValidationProvider", function (SlickAngularValidationProvider) {
  SlickAngularValidationProvider.setMessage('customvalidator', 'only custom values thanks!');
}])
```

## License
MIT

## TODO
Tests
