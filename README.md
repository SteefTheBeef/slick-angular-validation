Angular Validate
============

Slick form validation for AngularJS.

Requirements
--------
* AngularJS
* jQuery

License
-----
MIT

Install
-----
bower install slick-angular-validation
or clone this repo

Get going
-------
All your form field should reside within an form element.
The for element should have a name, like so:
```html
 <form name="daform">
 ...
``````
Validation messages is composed out of the name of the the field(with uppercased first letter) and a message part.
So an input like this:
```html
 <input type="text" ng-model="data.userName" name="userName" validate="required" />
``````
will generate a message like "UserName is required"

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
 <input type="checkbox" ng-model="data.terms" name="Terms & Conditions" validate="accepted" />
```

##### alpha
Field should only contain alphabetic characters
```html
 <input type="text" ng-model="data.userName" name="userName" validate="alpha" />
```

##### alphaDash
Field should only contain letters, numbers, underscores and dashes
```html
 <input type="text" ng-model="data.userName" name="userName" validate="alphaDash" />
```

##### alphaNumeric
Field should only contain letters and numbers
```html
 <input type="text" ng-model="data.userName" name="userName" validate="alphaDash" />
```

##### boolean
Field should have any of the values: true, false, 1, 0
```html
 <input type="text" ng-model="data.trueOrFalse" name="TrueOrFalse" validate="boolean" />
``````

##### date
Field should be a valid date
```html
 <input type="text" ng-model="data.startDate" name="startDate" validate="date" />
```

##### different
Should be used together with another field/model.<br/>
Field should be different to the other field/model.
```html
 <input type="text" ng-model="data.firstName" name="firstName" />
 <input type="text" ng-model="data.lastName" name="lastName" validate="different:data.firstName" />
```

##### email
Field should contain a valid email address.
```html
 <input type="text" ng-model="data.email" name="email" validate="email">
```

##### inString
Validates if value is found within the supplied model. <br/>
case insensitive.
```html
 <input type="text" ng-model="data.abbr" name="abbr" validate="inString:data.fullText" />
```

##### match
Field should match the value of the supplied model <br/>
case insensitive.
```html
 <input type="text" ng-model="data.password" name="password" />
 <input type="text" ng-model="data.passwordConfirmation" name="passwordConfirmation" validate="match:data.password" />
```
##### max
Field value cannot be greater than the supplied max value.
```html
 <input type="text" ng-model="data.max" name="max" validate="max:3"/>
```

##### maxDate
Field value cannot be greater than the supplied max date.
Could be used effectively with minDate to validate a dateSpan.
```html
<input type="date" ng-model="data.date1" name="date1" validate="maxDate:data.date2">
```

##### maxLength
Field character count should not exceed the supplied max length
```html
<input type="text" ng-model="data.maxLength" name="maxLength" validate="maxLength:3">
```

##### min
Field value cannot be less than the supplied min value.
```html
 <input type="text" ng-model="data.min" name="min" validate="min:3"/>
```

##### minDate
Field value cannot be less than the supplied min date.
Could be used effectively with maxDate to validate a dateSpan.
```html
<input type="date" ng-model="data.date2" name="date2" validate="minDate:data.date1">
```

##### minLength
Field character length should not be less than supplied min length
```html
<input type="text" ng-model="data.username" name="username" validate="minLength:5">
```

##### number
Field value should be a number
```html
<input type="text" ng-model="data.sum" name="sum" validate="number">
```

##### regex
Field value should contain supplied regex pattern
```html
<input type="text" ng-model="data.address" name="address" validate="regex:[A-Z]">
```

##### required
Field is required
```html
<input type="text" ng-model="data.zip" name="zip" validate="required">
```

##### requiredIf
Field is required if supplied model has the specified value
```html
<input type="text" ng-model="data.address" name="address" validate="requiredIf:data.zip=12345">
```




