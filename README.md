Angular Validate
============

Slick form validation for AngularJS.

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
Field value should not exceed the supplied max length
```html
<input type="text" ng-model="data.maxLength" name="maxLength" validate="maxLength:3">
```






