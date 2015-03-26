angular.module('slick-angular-validation', ['ngMessages']);

angular.module('slick-angular-validation').directive('validate', ["$compile", "$injector", "validateAttributeHelper", "messageContainerFactory", function($compile, $injector, validateAttributeHelper, messageContainerFactory) {
  var bindValidatorsAndCreateMessageContainer, unwatchers, validateCtrlNames;
  unwatchers = [];
  validateCtrlNames = function(formCtrl, modelCtrl) {
    if (!modelCtrl.$name) {
      throw 'missing attribute \'name\'';
    }
    if (!formCtrl.$name) {
      throw 'missing attribute \'name\' on parent form element';
    }
  };
  bindValidatorsAndCreateMessageContainer = function(scope, element, formCtrl, modelCtrl, attrs) {
    var arr, i, item, len, messageContainerElement, watchers;
    messageContainerElement = messageContainerFactory.beginContainer(formCtrl.$name, modelCtrl.$name);
    arr = validateAttributeHelper.toObject(attrs);
    for (i = 0, len = arr.length; i < len; i++) {
      item = arr[i];
      watchers = $injector.get(item.key).link(scope, modelCtrl, item.value);
      console.log(watchers);
      messageContainerElement += messageContainerFactory.createMessageFromItem(item, element);
    }
    messageContainerElement += messageContainerFactory.endContainer();
    return element.after($compile(messageContainerElement)(scope));
  };
  return {
    restrict: 'A',
    require: ['ngModel', '^form'],
    link: function(scope, element, attrs, ctrls) {
      var formCtrl, modelCtrl;
      modelCtrl = ctrls[0];
      formCtrl = ctrls[1];
      validateCtrlNames(formCtrl, modelCtrl);
      bindValidatorsAndCreateMessageContainer(scope, element, formCtrl, modelCtrl, attrs);
      element.removeAttr('validate');
      return scope.$on('$destroy', function() {});
    }
  };
}]);

angular.module('slick-angular-validation').factory('dateHelper', function() {
  return {
    isValid: function(date) {
      if (Object.prototype.toString.call(date) !== "[object Date]") {
        return false;
      }
      return !isNaN(test.getTime());
    }
  };
});

angular.module('slick-angular-validation').factory('messageContainerFactory', ["SlickAngularValidation", function(SlickAngularValidation) {
  var findNameOfOtherField, getMessage;
  findNameOfOtherField = function(element, itemValue) {
    var field, form;
    form = element.parents('form').first();
    if (!form.length) {
      return false;
    }
    field = form.find('*[ng-model="' + itemValue + '"]').first();
    if (!field.length) {
      return false;
    }
    return field.attr('name');
  };
  getMessage = function(item, element) {
    var messageObj, name;
    if (item.customMessage) {
      return item.customMessage;
    }
    messageObj = SlickAngularValidation.getMessage(item.key);
    if (messageObj.findName) {
      name = findNameOfOtherField(element, item.value);
      if (name) {
        return messageObj.message.replace('#value', name);
      }
    }
    return messageObj.message.replace('#value', item.value);
  };
  return {
    beginContainer: function(formCtrlName, modelCtrlName) {
      return '<ul ng-messages="' + formCtrlName + '.' + modelCtrlName + '.$error" class="slick-angular-validation-messages">';
    },
    createMessageFromItem: function(item, element) {
      return '<li ng-message="' + item.key + '">' + getMessage(item, element) + '</li>';
    },
    endContainer: function() {
      return '</ul>';
    }
  };
}]);

angular.module('slick-angular-validation').factory('validateAttributeHelper', function() {
  var process;
  process = function(attrs) {
    var customMessages;
    customMessages = {};
    if (attrs.messages) {
      attrs.messages.split('|').forEach(function(message) {
        var parts;
        parts = message.split(':');
        if (parts.length !== 2) {
          throw "Validation message attributes incorrect: " + message;
        }
        return customMessages[parts[0]] = parts[1];
      });
    }
    return attrs.validate.split('|').map(function(keyAndValue) {
      var keyValue;
      keyValue = keyAndValue.split(':');
      return {
        key: keyValue[0],
        value: keyValue[1],
        customMessage: customMessages[keyValue[0]]
      };
    });
  };
  return {
    toObject: function(attrs) {
      return process(attrs);
    }
  };
});

angular.module('slick-angular-validation').factory('valueHelper', ["$parse", function($parse) {
  return {
    isModel: function(expression) {
      if (/^[0-9]+/.test(expression)) {
        return false;
      }
      return !/^\'|\'$/.test(expression);
    },
    getValue: function(scope, isModel, val) {
      if (isModel) {
        return $parse(val)(scope);
      }
      return val.substring(1, val.length - 1);
    }
  };
}]);

angular.module('slick-angular-validation').provider('SlickAngularValidation', function() {
  this.messages = {
    accepted: {
      message: 'must be accepted'
    },
    alpha: {
      message: 'can only contain alphabetic characters'
    },
    alphadash: {
      message: 'can only contain letters, numbers, underscores and dashes'
    },
    alphanumeric: {
      message: 'can only contain letters and numbers'
    },
    boolean: {
      message: 'is not valid. Accepted input are true, false, 1, 0'
    },
    date: {
      message: 'is not a valid date'
    },
    different: {
      message: 'should be different to #value',
      findName: true
    },
    email: {
      message: 'is not a valid email'
    },
    instring: {
      message: 'cannot be found within #value'
    },
    match: {
      message: 'must match #value',
      findName: true
    },
    max: {
      message: 'cannot be greater than #value'
    },
    maxdate: {
      message: 'should be less than #value',
      findName: true
    },
    maxlength: {
      message: 'cannot exceed #value characters'
    },
    min: {
      message: 'cannot be less than #value'
    },
    mindate: {
      message: 'should be greater than #value',
      findName: true
    },
    minlength: {
      message: 'cannot be less than #value characters'
    },
    number: {
      message: 'is not a valid number'
    },
    pattern: {
      message: 'is not valid'
    },
    required: {
      message: 'is required'
    },
    requiredif: {
      message: 'is required'
    },
    url: {
      message: 'is not a valid url'
    }
  };
  this.setMessage = function(key, message, findName) {
    if (findName == null) {
      findName = false;
    }
    return this.messages[key] = {
      message: message,
      findName: findName
    };
  };
  this.$get = function() {
    return {
      getMessage: (function(_this) {
        return function(key) {
          return _this.messages[key];
        };
      })(this)
    };
  };
});

angular.module('slick-angular-validation').factory('accepted', function() {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.accepted = function(modelValue, viewValue) {
        var viewVal;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        viewVal = viewValue.toLowerCase();
        return viewVal === 'true' || viewVal === '1';
      };
    }
  };
});

angular.module('slick-angular-validation').factory('alpha', function() {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.alpha = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        return /^[a-zA-Z]+$/i.test(viewValue);
      };
    }
  };
});

angular.module('slick-angular-validation').factory('alphadash', function() {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.alphadash = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        return /^[a-zA-Z0-9-_]+$/i.test(viewValue);
      };
    }
  };
});

angular.module('slick-angular-validation').factory('alphaNumeric', function() {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.alphanumeric = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        return /^[a-zA-Z0-9]+$/i.test(viewValue);
      };
    }
  };
});

angular.module('slick-angular-validation').factory('boolean', function() {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.boolean = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        switch (viewValue.toLowerCase()) {
          case 'true':
            return true;
          case 'false':
            return true;
          case '1':
            return true;
          case '0':
            return true;
        }
        return false;
      };
    }
  };
});

angular.module('slick-angular-validation').factory('date', ["dateHelper", function(dateHelper) {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.date = function(modelValue, viewValue) {
        var test;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        test = new Date(viewValue);
        return dateHelper.isValid(test);
      };
    }
  };
}]);

angular.module('slick-angular-validation').factory('different', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, otherNgModelName) {
      var isModel;
      isModel = valueHelper.isModel(otherNgModelName);
      ctrl.$validators.different = function(modelValue, viewValue) {
        var otherValue;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        otherValue = valueHelper.getValue(scope, isModel, otherNgModelName);
        viewValue !== otherValue;
        if (isModel) {
          return scope.$watch(otherNgModelName, function() {
            return ctrl.$validate();
          });
        }
      };
    }
  };
}]);

angular.module('slick-angular-validation').factory('email', function() {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.max = function(modelValue, viewValue) {
        var regex;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        regex = /^[A-Z0-9_'%=+!`#~$*?^{}&|-]+([\.][A-Z0-9_'%=+!`#~$*?^{}&|-]+)*@[A-Z0-9-]+(\.[A-Z0-9-]+)+$/i;
        return regex.test(viewValue);
      };
    }
  };
});

angular.module('slick-angular-validation').factory('instring', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, haystack) {
      var isModel;
      isModel = valueHelper.isModel(haystack);
      ctrl.$validators.instring = function(modelValue, viewValue) {
        var value;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        value = valueHelper.getValue(scope, isModel, haystack);
        return value.toLowerCase().indexOf(viewValue.toLowerCase()) !== -1;
      };
      if (isModel) {
        return scope.$watch(haystack, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('match', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, otherNgModelName) {
      var isModel;
      isModel = valueHelper.isModel(otherNgModelName);
      ctrl.$validators.match = function(modelValue, viewValue) {
        var otherValue;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        otherValue = valueHelper.getValue(scope, isModel, otherNgModelName);
        return viewValue === otherValue;
      };
      if (isModel) {
        return scope.$watch(otherNgModelName, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('max', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, maxValue) {
      var isModel;
      isModel = valueHelper.isModel(maxValue);
      ctrl.$validators.max = function(modelValue, viewValue) {
        var parsedMax, parsedViewValue;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        parsedViewValue = parseFloat(viewValue);
        parsedMax = parseFloat(valueHelper.getValue(scope, isModel, maxValue));
        if (isNaN(parsedMax)) {
          throw "invalid max value";
        }
        if (isNaN(parsedViewValue)) {
          return false;
        }
        return parsedViewValue <= parsedMax;
      };
      if (isModel) {
        return scope.$watch(maxValue, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('maxdate', ["valueHelper", "dateHelper", function(valueHelper, dateHelper) {
  return {
    link: function(scope, ctrl, otherDate) {
      var isModel;
      isModel = valueHelper.isModel(otherDate);
      ctrl.$validators.maxdate = function(modelValue, viewValue) {
        var oDate, viewValueDate;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        viewValueDate = new Date(viewValue);
        if (!dateHelper.isValid(viewValueDate)) {
          return true;
        }
        oDate = new Date(valueHelper.getValue(scope, isModel, otherDate));
        if (!dateHelper.isValid(viewValueDate)) {
          return true;
        }
        return viewValueDate < oDate;
      };
      if (isModel) {
        return scope.$watch(otherDate, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('maxlength', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, maxlength) {
      var isModel;
      isModel = valueHelper.isModel(maxlength);
      ctrl.$validators.maxlength = function(modelValue, viewValue) {
        var maxlen;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        maxlen = valueHelper.getValue(scope, isModel, maxlength);
        return viewValue.length <= parseInt(maxlen);
      };
      if (isModel) {
        return scope.$watch(maxlength, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('min', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, minValue) {
      var isModel;
      isModel = valueHelper.isModel(minValue);
      ctrl.$validators.min = function(modelValue, viewValue) {
        var parsedMin, parsedViewValue;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        parsedViewValue = parseFloat(viewValue);
        parsedMin = parseFloat(valueHelper.getValue(scope, isModel, minValue));
        if (isNaN(parsedMin)) {
          throw "invalid max value";
        }
        if (isNaN(parsedViewValue)) {
          return false;
        }
        return parsedViewValue >= parsedMin;
      };
      if (isModel) {
        return scope.$watch(minValue, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('mindate', ["valueHelper", "dateHelper", function(valueHelper, dateHelper) {
  return {
    link: function(scope, ctrl, otherDate) {
      var isModel;
      isModel = valueHelper.isModel(otherDate);
      ctrl.$validators.mindate = function(modelValue, viewValue) {
        var oDate, viewValueDate;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        viewValueDate = new Date(viewValue);
        if (!dateHelper.isValid(viewValueDate)) {
          return true;
        }
        oDate = new Date(valueHelper.getValue(scope, isModel, otherDate));
        if (!dateHelper.isValid(viewValueDate)) {
          return true;
        }
        return viewValueDate > oDate;
      };
      if (isModel) {
        return scope.$watch(otherDate, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('minlength', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, minlength) {
      var isModel;
      isModel = valueHelper.isModel(minlength);
      ctrl.$validators.minlength = function(modelValue, viewValue) {
        var minlen;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        minlen = valueHelper.getValue(scope, isModel, minlength);
        return viewValue.length >= parseInt(minlen);
      };
      if (isModel) {
        return scope.$watch(minlength, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('number', function() {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.number = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        return !isNaN(viewValue);
      };
    }
  };
});

angular.module('slick-angular-validation').factory('pattern', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, pattern) {
      var isModel;
      isModel = valueHelper.isModel(pattern);
      ctrl.$validators.pattern = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        return new RegExp(valueHelper.getValue(scope, isModel, pattern)).test(viewValue);
      };
      if (isModel) {
        return scope.$watch(pattern, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('required', function() {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.required = function(modelValue, viewValue) {
        return !ctrl.$isEmpty(modelValue);
      };
    }
  };
});

angular.module('slick-angular-validation').factory('requiredif', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, otherValue) {
      var isModel, part1IsModel, valueParts, watchers;
      isModel = true;
      valueParts = otherValue.split('=');
      if (valueParts.length !== 2) {
        throw 'Invalid format of requiredif: ' + otherValue;
      }
      part1IsModel = valueHelper.isModel(valueParts[1]);
      ctrl.$validators.requiredif = function(modelValue, viewValue) {
        var value0, value1;
        value0 = valueHelper.getValue(scope, isModel, valueParts[0]);
        value1 = valueHelper.getValue(scope, part1IsModel, valueParts[1]);
        if (value0 === value1 && ctrl.$isEmpty(modelValue)) {
          return false;
        }
        return true;
      };
      watchers = [];
      watchers.push(scope.$watch(valueParts[0], function() {
        return ctrl.$validate();
      }));
      if (part1IsModel) {
        watchers.push(scope.$watch(valueParts[1], function() {
          return ctrl.$validate();
        }));
      }
      return watchers;
    }
  };
}]);

angular.module('slick-angular-validation').factory('url', function() {
  var urlRegex;
  urlRegex = /^(?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/i;
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.url = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        return urlRegex.test(viewValue);
      };
    }
  };
});
