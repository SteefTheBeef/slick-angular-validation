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

##### alpha
Field should only contain alphabetic characters
```html
 <input type="text" ng-model="data.userName" name="userName" validate="alpha">
```

##### alphaDash
Field should only contain letters, numbers, underscores and dashes
```html
 <input type="text" ng-model="data.userName" name="userName" validate="alphaDash">
```

##### alphaNumeric
Field should only contain letters and numbers
```html
 <input type="text" ng-model="data.userName" name="userName" validate="alphaDash">
```

##### boolean
Field should have any of the values: true, false, 1, 0
```html
 <input type="text" ng-model="data.trueOrFalse" name="TrueOrFalse" validate="boolean">
``````

##### date
Field should be a valid date
```html
 <input type="text" ng-model="data.startDate" name="startDate" validate="date">
```

##### different
Should be used together with another field/model.
Field should be different to the other field/model.
```html
 <input type="text" ng-model="data.firstName" name="firstName">
 <input type="text" ng-model="data.lastName" name="lastName" validate="different:data.firstName">
```






