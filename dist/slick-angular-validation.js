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
      if (modelValue === 'true' || parseInt(modelValue) === 1) {
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
      return 'should be different to #prettyvalue';
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
      return 'cannot be less than #value';
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
      return 'does not match not #value';
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

angular.module('slick-angular-validation.rules').factory('regex', function() {
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

angular.module('slick-angular-validation.rules').factory('rules', ["accepted", "alpha", "alphaDash", "alphaNumeric", "boolean", "inString", "date", "different", "email", "match", "max", "maxDate", "maxLength", "min", "minDate", "minLength", "number", "regex", "required", "requiredIf", function(accepted, alpha, alphaDash, alphaNumeric, boolean, inString, date, different, email, match, max, maxDate, maxLength, min, minDate, minLength, number, regex, required, requiredIf) {
  return {
    getMessages: function() {
      return {
        accepted: accepted.message(),
        alpha: alpha.message(),
        alphaDash: alphaDash.message(),
        alphaNumeric: alphaNumeric.message(),
        boolean: boolean.message(),
        inString: inString.message(),
        date: date.message(),
        different: different.message(),
        email: email.message(),
        match: match.message(),
        max: max.message(),
        maxDate: maxDate.message(),
        maxLength: maxLength.message(),
        min: min.message(),
        minDate: minDate.message(),
        minLength: minLength.message(),
        number: number.message(),
        regex: regex.message(),
        required: required.message(),
        requiredIf: requiredIf.message()
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
  getDefaultMessage = function(attribute) {
    var msg;
    msg = rules.getMessages()[attribute.key];
    if (!msg) {
      return "";
    }
    return msg.replace('#value', attribute.value).replace('#prettyvalue', attribute.value ? attribute.value.replace('_', ' ') : void 0);
  };
  getTransformedName = function(unformatedName) {
    var result;
    result = unformatedName.charAt(0).toUpperCase() + unformatedName.slice(1);
    result = result.replace(/([A-Z]+)/g, "$1").replace(/([A-Z][a-z])/g, "$1");
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
    return '<ul class="angular-validate-messages" style="display:none">';
  };
  getListItem = function(elementName, attributeKey, message) {
    return '<li class="' + elementName + '-error-' + attributeKey + '">' + message + '</li>';
  };
  getMessage = function(displayName, attribute) {
    if (attribute.message) {
      return displayName + ' ' + attribute.message;
    } else {
      return displayName + ' ' + getDefaultMessage(attribute);
    }
  };
  return {
    create: function(element, attrs) {
      var attribute, elem, names, validationAttributes, validationBlock, _i, _len;
      elem = $(element[0]);
      names = getNames(elem);
      validationAttributes = getValidationAttributes(attrs.validate, attrs.validateMessages);
      validationBlock = getValidationElementStart();
      for (_i = 0, _len = validationAttributes.length; _i < _len; _i++) {
        attribute = validationAttributes[_i];
        validationBlock += getListItem(names.elementName, attribute.key, getMessage(names.displayName, attribute));
      }
      validationBlock += '</ul>';
      elem.after(validationBlock);
      return {
        element: elem.next(),
        attributes: validationAttributes
      };
    }
  };
}]);

angular.module('slick-angular-validation', ['slick-angular-validation.rules', 'slick-angular-validation.factory']).directive('validate', ["$timeout", "$parse", "validationElementFactory", "accepted", "alpha", "alphaDash", "alphaNumeric", "boolean", "inString", "date", "different", "email", "match", "max", "maxDate", "maxLength", "min", "minDate", "minLength", "number", "regex", "required", "requiredIf", function($timeout, $parse, validationElementFactory, accepted, alpha, alphaDash, alphaNumeric, boolean, inString, date, different, email, match, max, maxDate, maxLength, min, minDate, minLength, number, regex, required, requiredIf) {
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
        var formCtrl, modelCtrl;
        modelCtrl = ctrls[0];
        formCtrl = ctrls[1];
        return $timeout(function() {
          var getModelValue, getParsedValue, run, setIsValid, toggleElement, toggleItem, watchEquality, watchModel, watchSubmit;
          watchEquality = function() {
            var attribute, _i, _len, _ref, _results;
            _ref = validation.attributes;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              attribute = _ref[_i];
              if (attribute.key === 'match') {
                scope.$watch(attribute.value, (function(_this) {
                  return function() {
                    return $timeout(function() {
                      modelCtrl.$setDirty();
                      return run([attribute]);
                    });
                  };
                })(this));
              }
              if (attribute.key === 'different') {
                scope.$watch(attribute.value, (function(_this) {
                  return function() {
                    return $timeout(function() {
                      modelCtrl.$setDirty();
                      return run([attribute]);
                    });
                  };
                })(this));
              }
              if (attribute.key === 'minDate') {
                scope.$watch(attribute.value, (function(_this) {
                  return function() {
                    return $timeout(function() {
                      modelCtrl.$setDirty();
                      return run([attribute]);
                    });
                  };
                })(this));
              }
              if (attribute.key === 'maxDate') {
                scope.$watch(attribute.value, (function(_this) {
                  return function() {
                    return $timeout(function() {
                      modelCtrl.$setDirty();
                      return run([attribute]);
                    });
                  };
                })(this));
              }
              if (attribute.key === 'requiredIf') {
                _results.push(scope.$watch(attribute.value, (function(_this) {
                  return function() {
                    return $timeout(function() {
                      modelCtrl.$setDirty();
                      return run([attribute]);
                    });
                  };
                })(this)));
              } else {
                _results.push(void 0);
              }
            }
            return _results;
          };
          watchSubmit = function() {
            if (!(formCtrl && formCtrl.$name)) {
              return;
            }
            return scope.$watch(formCtrl.$name + '.$submitted', function(value) {
              if (value === true) {
                modelCtrl.$setDirty();
                return run();
              }
            });
          };
          watchModel = function() {
            var validationCount;
            validationCount = 0;
            return scope.$watch(attrs.ngModel, function() {
              if (validationCount > 0) {
                run();
              }
              return validationCount++;
            });
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
              return toggleItem(validationKey, 'none');
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
                case 'regex':
                  result = regex.validate(modelValue, attribute.value);
                  break;
                case 'required':
                  result = required.validate(modelValue);
                  break;
                case 'requiredIf':
                  result = requiredIf.validate(modelValue, $parse(attribute.value)(scope), getParsedValue(attribute.value2));
              }
              setIsValid(attribute.key, result);
              _results.push(toggleElement(attribute.key, result));
            }
            return _results;
          };
          watchSubmit();
          watchModel();
          watchEquality();
          element.blur(function() {
            return run();
          });
          if (attrs.type && (attrs.type === 'checkbox' || attrs.type === 'radio')) {
            element.change(function() {
              return run();
            });
          }
          return run();
        });
      };
    }
  };
}]);
