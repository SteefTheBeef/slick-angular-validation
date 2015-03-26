angular.module('slick-angular-validation', []);

angular.module('slick-angular-validation.rules', []);

angular.module('slick-angular-validation.factory', []);

angular.module('slick-angular-validation.rules').factory('accepted', function() {
  return {
    message: function() {
      return 'must be accepted';
    },
    validate: function(modelValue) {
      if (modelValue === "") {
        return true;
      }
      modelValue = modelValue.toLowerCase();
      if (modelValue === 'true' || modelValue === '1') {
        return true;
      }
      return false;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('alpha', function() {
  return {
    message: function() {
      return 'can only contain alphabetic characters';
    },
    validate: function(modelValue) {
      if (modelValue === "") {
        return true;
      }
      return /^[a-zA-Z]+$/i.test(modelValue);
    }
  };
});

angular.module('slick-angular-validation.rules').factory('alphaDash', function() {
  return {
    message: function() {
      return 'can only contain letters, numbers, underscores and dashes';
    },
    validate: function(modelValue) {
      if (modelValue === "") {
        return true;
      }
      if (modelValue && /^[a-zA-Z0-9-_]+$/i.test(modelValue)) {
        return true;
      }
      return false;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('alphaNumeric', function() {
  return {
    message: function() {
      return 'can only contain letters and numbers';
    },
    validate: function(modelValue) {
      if (modelValue === "") {
        return true;
      }
      if (modelValue && /^[a-zA-Z0-9]+$/i.test(modelValue)) {
        return true;
      }
      return false;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('boolean', function() {
  return {
    message: function() {
      return 'is not valid. Accepted input are true, false, 1, 0';
    },
    validate: function(modelValue) {
      if (modelValue === "") {
        return true;
      }
      switch (modelValue) {
        case true:
          return true;
        case false:
          return true;
        case 1:
          return true;
        case 0:
          return true;
      }
      if (angular.isString(modelValue)) {
        modelValue = modelValue.toLowerCase();
        switch (modelValue) {
          case 'true':
            return true;
          case 'false':
            return true;
          case '1':
            return true;
          case '0':
            return true;
        }
      }
      return false;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('date', function() {
  return {
    message: function() {
      return 'is not a valid date';
    },
    validate: function(modelValue) {
      var test;
      if (modelValue === "") {
        return true;
      }
      test = new Date(modelValue);
      if (Object.prototype.toString.call(test) !== "[object Date]") {
        return false;
      }
      return !isNaN(test.getTime());
    }
  };
});

angular.module('slick-angular-validation.rules').factory('different', function() {
  return {
    message: function() {
      return 'should be different to #value';
    },
    validate: function(modelValue, otherValue) {
      if (modelValue === "") {
        return true;
      }
      return modelValue !== otherValue;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('email', function() {
  return {
    message: function() {
      return 'is not a valid email';
    },
    validate: function(modelValue) {
      var regex;
      if (modelValue === "") {
        return true;
      }
      regex = /^[A-Z0-9_'%=+!`#~$*?^{}&|-]+([\.][A-Z0-9_'%=+!`#~$*?^{}&|-]+)*@[A-Z0-9-]+(\.[A-Z0-9-]+)+$/i;
      if (modelValue && regex.test(modelValue)) {
        return true;
      }
      return false;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('inString', function() {
  return {
    message: function() {
      return 'cannot be found within #value';
    },
    validate: function(modelValue, haystack) {
      if (modelValue === "") {
        return true;
      }
      if (angular.isString(haystack) && angular.isString(modelValue)) {
        haystack = haystack.toLowerCase();
        return haystack.indexOf(modelValue.toLowerCase()) !== -1;
      }
      return false;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('match', function() {
  return {
    message: function() {
      return 'must match #value';
    },
    validate: function(modelValue, otherValue) {
      if (modelValue === "") {
        return true;
      }
      return modelValue === otherValue;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('max', function() {
  return {
    message: function() {
      return 'cannot be greater than #value';
    },
    validate: function(modelValue, max) {
      if (modelValue === "") {
        return true;
      }
      modelValue = parseFloat(modelValue);
      max = parseFloat(max);
      if (isNaN(modelValue) || isNaN(max)) {
        return null;
      }
      return modelValue <= max;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('maxDate', ["date", function(date) {
  return {
    message: function() {
      return 'should be less than #value';
    },
    validate: function(modelValue, otherDate) {
      if (modelValue === "") {
        return true;
      }
      if (!(date.validate(modelValue) && date.validate(otherDate))) {
        return true;
      }
      return new Date(modelValue) < new Date(otherDate);
    }
  };
}]);

angular.module('slick-angular-validation.rules').factory('maxLength', function() {
  return {
    message: function() {
      return 'cannot exceed #value characters';
    },
    validate: function(modelValue, maxlength) {
      if (modelValue === "") {
        return true;
      }
      if (modelValue && modelValue.length <= parseInt(maxlength)) {
        return true;
      }
      return false;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('min', function() {
  return {
    message: function() {
      return 'cannot be less than #value';
    },
    validate: function(modelValue, min) {
      if (modelValue === "") {
        return true;
      }
      modelValue = parseFloat(modelValue);
      min = parseFloat(min);
      if (isNaN(modelValue) || isNaN(min)) {
        return null;
      }
      return modelValue >= min;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('minDate', ["date", function(date) {
  return {
    message: function() {
      return 'should be greater than #value';
    },
    validate: function(modelValue, otherDate) {
      if (modelValue === "") {
        return true;
      }
      if (!(date.validate(modelValue) && date.validate(otherDate))) {
        return null;
      }
      return new Date(modelValue) > new Date(otherDate);
    }
  };
}]);

angular.module('slick-angular-validation.rules').factory('minLength', function() {
  return {
    message: function() {
      return 'cannot be less than #value characters';
    },
    validate: function(modelValue, minlength) {
      if (modelValue === "") {
        return true;
      }
      if (modelValue && modelValue.length >= parseInt(minlength)) {
        return true;
      }
      return false;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('number', function() {
  return {
    message: function() {
      return 'is not a valid number';
    },
    validate: function(modelValue) {
      if (modelValue === "") {
        return true;
      }
      return !isNaN(modelValue);
    }
  };
});

angular.module('slick-angular-validation.rules').factory('pattern', function() {
  return {
    message: function() {
      return 'is not valid';
    },
    validate: function(modelValue, regex) {
      if (modelValue === "") {
        return true;
      }
      return new RegExp(regex).test(modelValue);
    }
  };
});

angular.module('slick-angular-validation.rules').factory('required', function() {
  return {
    message: function() {
      return 'is required';
    },
    validate: function(modelValue) {
      if (modelValue === void 0 || modelValue === null || modelValue === '') {
        return false;
      }
      return true;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('requiredIf', function() {
  return {
    message: function() {
      return 'is required';
    },
    validate: function(modelValue, otherValue, value2) {
      if (otherValue === value2.toString() && modelValue.length <= 0) {
        return false;
      }
      return true;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('url', function() {
  var urlRegex;
  urlRegex = /^(?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/i;
  return {
    message: function() {
      return 'is not a valid url';
    },
    validate: function(modelValue) {
      if (modelValue === "") {
        return true;
      }
      if (modelValue && urlRegex.test(modelValue)) {
        return true;
      }
      return false;
    }
  };
});

angular.module('slick-angular-validation.rules').factory('rules', ["accepted", "alpha", "alphaDash", "alphaNumeric", "boolean", "inString", "date", "different", "email", "match", "max", "maxDate", "maxLength", "min", "minDate", "minLength", "number", "pattern", "required", "requiredIf", "url", function(accepted, alpha, alphaDash, alphaNumeric, boolean, inString, date, different, email, match, max, maxDate, maxLength, min, minDate, minLength, number, pattern, required, requiredIf, url) {
  return {
    get: function() {
      return {
        accepted: {
          message: accepted.message(),
          prettify: false
        },
        alpha: {
          message: alpha.message(),
          prettify: false
        },
        alphaDash: {
          message: alphaDash.message(),
          prettify: false
        },
        alphaNumeric: {
          message: alphaNumeric.message(),
          prettify: false
        },
        boolean: {
          message: boolean.message(),
          prettify: false
        },
        inString: {
          message: inString.message(),
          prettify: true
        },
        date: {
          message: date.message(),
          prettify: false
        },
        different: {
          message: different.message(),
          prettify: true
        },
        email: {
          message: email.message(),
          prettify: false
        },
        match: {
          message: match.message(),
          prettify: true
        },
        max: {
          message: max.message(),
          prettify: false
        },
        maxDate: {
          message: maxDate.message(),
          prettify: true
        },
        maxLength: {
          message: maxLength.message(),
          prettify: false
        },
        min: {
          message: min.message(),
          prettify: false
        },
        minDate: {
          message: minDate.message(),
          prettify: true
        },
        minLength: {
          message: minLength.message(),
          prettify: false
        },
        number: {
          message: number.message(),
          prettify: false
        },
        pattern: {
          message: pattern.message(),
          prettify: false
        },
        required: {
          message: required.message(),
          prettify: false
        },
        requiredIf: {
          message: requiredIf.message(),
          prettify: true
        },
        url: {
          message: url.message(),
          prettify: false
        }
      };
    }
  };
}]);

angular.module('slick-angular-validation.factory', ['slick-angular-validation.rules']).factory('validationElementFactory', ["$compile", "rules", function($compile, rules) {
  var getDefaultMessage, getListItem, getMessage, getNames, getTransformedName, getValidationAttributes, getValidationElementStart;
  getValidationAttributes = function(validationAttribute, validationMessages) {
    var message;
    if (!validationAttribute) {
      return [];
    }
    message = {};
    if (validationMessages) {
      validationMessages.split('|').forEach(function(validationMessage) {
        var parts;
        parts = validationMessage.split(':');
        if (parts.length !== 2) {
          throw "Validation message attributes incorrect: " + validationMessage;
        }
        return message[parts[0]] = parts[1];
      });
    }
    return validationAttribute.split('|').map(function(validationRule) {
      var keyValue, lastParts, result;
      keyValue = validationRule.split(':');
      result = {
        key: keyValue[0],
        value: keyValue[1],
        message: message[keyValue[0]]
      };
      if (keyValue.length > 1) {
        lastParts = keyValue[1].split('=');
        result.value = lastParts[0];
        result.value2 = lastParts[1];
      }
      return result;
    });
  };
  getDefaultMessage = function(attribute, elem) {
    var currentRule, field, form, msg;
    currentRule = rules.get()[attribute.key];
    if (!currentRule) {
      throw 'Validation rule:' + attribute.key + ' does not exist';
    }
    msg = currentRule['message'];
    if (!msg) {
      return "";
    }
    if (!currentRule.prettify) {
      return msg.replace('#value', attribute.value);
    }
    form = elem.parents('form').first();
    if (!form.length) {
      return msg.replace('#value', attribute.value);
    }
    field = form.find('*[ng-model="' + attribute.value + '"]').first();
    if (!field.length) {
      return msg.replace('#value', attribute.value);
    }
    return msg.replace('#value', field.attr('name'));
  };
  getTransformedName = function(unformatedName) {
    var result;
    result = unformatedName.charAt(0).toUpperCase() + unformatedName.slice(1);
    result = result.replace(/([A-Z]+)/g, "$1").replace(/([A-Z][a-z])/g, " $1");
    return result;
  };
  getNames = function(elem) {
    var elementName;
    elementName = elem.attr('name');
    return {
      elementName: elementName,
      displayName: getTransformedName(elementName)
    };
  };
  getValidationElementStart = function() {
    return '<ul class="slick-angular-validation" style="display:none">';
  };
  getListItem = function(elementName, attributeKey, message) {
    return '<li class="' + elementName + '-error-' + attributeKey + ' text-danger">' + message + '</li>';
  };
  getMessage = function(displayName, attribute, elem) {
    if (attribute.message) {
      return attribute.message;
    } else {
      return displayName + ' ' + getDefaultMessage(attribute, elem);
    }
  };
  return {
    create: function(element, attrs) {
      var attribute, elem, names, ulElement, validationAttributes, validationBlock, _i, _len;
      elem = $(element[0]);
      names = getNames(elem);
      validationAttributes = getValidationAttributes(attrs.validate, attrs.validateMessages);
      validationBlock = getValidationElementStart();
      for (_i = 0, _len = validationAttributes.length; _i < _len; _i++) {
        attribute = validationAttributes[_i];
        validationBlock += getListItem(names.elementName, attribute.key, getMessage(names.displayName, attribute, elem));
      }
      validationBlock += '</ul>';
      elem.after(validationBlock);
      ulElement = elem.next();
      return {
        element: ulElement,
        children: ulElement.children(),
        attributes: validationAttributes
      };
    }
  };
}]);

angular.module('slick-angular-validation', ['slick-angular-validation.rules', 'slick-angular-validation.factory']).directive('validate', ["$timeout", "$parse", "validationElementFactory", "accepted", "alpha", "alphaDash", "alphaNumeric", "boolean", "inString", "date", "different", "email", "match", "max", "maxDate", "maxLength", "min", "minDate", "minLength", "number", "pattern", "required", "requiredIf", "url", function($timeout, $parse, validationElementFactory, accepted, alpha, alphaDash, alphaNumeric, boolean, inString, date, different, email, match, max, maxDate, maxLength, min, minDate, minLength, number, pattern, required, requiredIf, url) {
  return {
    restrict: 'A',
    require: ['ngModel', '^form'],
    compile: function(element, attrs) {
      var validation;
      if (!attrs.name) {
        throw 'missing attribute name';
      }
      validation = validationElementFactory.create(element, attrs);
      return function(scope, element, attrs, ctrls) {
        var formCtrl, getModelValue, getParsedValue, getValidateOn, modelCtrl, run, setIsValid, toggleElement, toggleItem, unwatchEquality, unwatchModel, unwatchSubmit, validateOn, watchEquality, watchModel, watchSubmit;
        modelCtrl = ctrls[0];
        formCtrl = ctrls[1];
        getValidateOn = function() {
          var elementValidation, getElementValidateOn, getIt, setFormCtrlValidateOn;
          getElementValidateOn = function() {
            if (!attrs.validateOn) {
              return 'empty';
            }
            switch (attrs.validateOn) {
              case 'blur':
                return 'blur';
              case 'change':
                return 'change';
            }
            return 'empty';
          };
          getIt = function(valOn) {
            if (!valOn) {
              return 'empty';
            }
            switch (valOn) {
              case 'blur':
                return 'blur';
              case 'change':
                return 'change';
            }
            return 'empty';
          };
          setFormCtrlValidateOn = function() {
            var form, validateOn;
            form = element.parents('form').first();
            validateOn = form.attr('validate-on');
            return formCtrl.validateOn = getIt(validateOn);
          };
          elementValidation = getElementValidateOn();
          if (elementValidation !== 'empty') {
            return elementValidation;
          }
          if (!formCtrl.validateOn) {
            setFormCtrlValidateOn();
          }
          return formCtrl.validateOn;
        };
        watchEquality = function() {
          var attribute, unwatchEquality, _i, _len, _ref;
          unwatchEquality = null;
          _ref = validation.attributes;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            attribute = _ref[_i];
            switch (attribute.key) {
              case 'match':
              case 'different':
              case 'minDate':
              case 'maxDate':
              case 'requiredIf':
                unwatchEquality = scope.$watch(attribute.value, (function(_this) {
                  return function() {
                    modelCtrl.$setDirty();
                    return run([attribute]);
                  };
                })(this));
            }
          }
          return unwatchEquality;
        };
        watchSubmit = function() {
          var unwatchSubmit;
          if (!(formCtrl && formCtrl.$name)) {
            return;
          }
          unwatchSubmit = scope.$watch(formCtrl.$name + '.$submitted', function(value) {
            if (value === true) {
              modelCtrl.$setDirty();
              return run();
            }
          });
          return unwatchSubmit;
        };
        watchModel = function() {
          var unwatchModel, validationCount;
          validationCount = 0;
          unwatchModel = scope.$watch(attrs.ngModel, function() {
            if (validationCount > 0) {
              run();
            }
            return validationCount++;
          });
          return unwatchModel;
        };
        toggleItem = function(validationKey, display) {
          return validation.element.children('.' + modelCtrl.$name + '-error-' + validationKey).css('display', display);
        };
        toggleElement = function(validationKey, isValid) {
          if (modelCtrl.$pristine) {
            return;
          }
          if (!isValid) {
            validation.element.css('display', 'block');
            return toggleItem(validationKey, 'list-item');
          } else {
            toggleItem(validationKey, 'none');
            if (!validation.children.filter(":visible").length) {
              return validation.element.css('display', 'none');
            }
          }
        };
        setIsValid = function(key, isValid) {
          return modelCtrl.$setValidity(key, isValid);
        };
        getModelValue = function() {
          if (modelCtrl.$modelValue === false || modelCtrl.$modelValue) {
            return $.trim(modelCtrl.$modelValue.toString());
          }
          return "";
        };
        getParsedValue = function(value) {
          var val;
          val = $parse(value)(scope);
          if (!val) {
            return value;
          }
          return val;
        };
        run = function(specificValidationAttributes) {
          var attribute, modelValue, result, _i, _len, _ref, _results;
          modelValue = getModelValue();
          _ref = specificValidationAttributes || validation.attributes;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            attribute = _ref[_i];
            result = null;
            switch (attribute.key) {
              case 'accepted':
                result = accepted.validate(modelValue);
                break;
              case 'alpha':
                result = alpha.validate(modelValue);
                break;
              case 'alphaDash':
                result = alphaDash.validate(modelValue);
                break;
              case 'alphaNumeric':
                result = alphaNumeric.validate(modelValue);
                break;
              case 'boolean':
                result = boolean.validate(modelValue);
                break;
              case 'inString':
                result = inString.validate(modelValue, $parse(attribute.value)(scope));
                break;
              case 'date':
                result = date.validate(modelValue, attribute.value);
                break;
              case 'different':
                result = different.validate(modelValue, $parse(attribute.value)(scope));
                break;
              case 'email':
                result = email.validate(modelValue);
                break;
              case 'match':
                result = match.validate(modelValue, $parse(attribute.value)(scope));
                break;
              case 'max':
                result = max.validate(modelValue, attribute.value);
                break;
              case 'maxLength':
                result = maxLength.validate(modelValue, attribute.value);
                break;
              case 'min':
                result = min.validate(modelValue, attribute.value);
                break;
              case 'maxDate':
                result = maxDate.validate(modelValue, $parse(attribute.value)(scope));
                break;
              case 'minDate':
                result = minDate.validate(modelValue, $parse(attribute.value)(scope));
                break;
              case 'minLength':
                result = minLength.validate(modelValue, attribute.value);
                break;
              case 'number':
                result = number.validate(modelValue);
                break;
              case 'pattern':
                result = pattern.validate(modelValue, attribute.value);
                break;
              case 'required':
                result = required.validate(modelValue);
                break;
              case 'requiredIf':
                result = requiredIf.validate(modelValue, $parse(attribute.value)(scope), getParsedValue(attribute.value2));
                break;
              case 'url':
                result = url.validate(modelValue);
            }
            setIsValid(attribute.key, result);
            _results.push(toggleElement(attribute.key, result));
          }
          return _results;
        };
        unwatchSubmit = watchSubmit();
        validateOn = getValidateOn();
        if (validateOn !== 'blur') {
          unwatchModel = watchModel();
          unwatchEquality = watchEquality();
        }
        element.bind('blur', function() {
          return run();
        });
        if (attrs.type && (attrs.type === 'checkbox' || attrs.type === 'radio')) {
          element.bind('change', function() {
            return run();
          });
        }
        run();
        return scope.$on('$destroy', function() {
          if (unwatchSubmit) {
            unwatchSubmit();
          }
          if (unwatchModel) {
            unwatchModel();
          }
          if (unwatchEquality) {
            unwatchEquality();
          }
          return element.unbind();
        });
      };
    }
  };
}]);
