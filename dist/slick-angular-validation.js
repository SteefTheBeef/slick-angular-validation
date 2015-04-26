angular.module('slick-angular-validation', ['ngMessages']);

angular.module('slick-angular-validation').directive('validate', ["$compile", "$injector", "validateAttributeHelper", "messageContainerFactory", function($compile, $injector, validateAttributeHelper, messageContainerFactory) {
  var addWatcher, bindValidatorsAndCreateMessageContainer, unwatchers, validateCtrlNames;
  unwatchers = [];
  addWatcher = function(watcher) {
    var i, len, results, w;
    if (angular.isArray(watcher)) {
      results = [];
      for (i = 0, len = watcher.length; i < len; i++) {
        w = watcher[i];
        results.push(unwatchers.push(w));
      }
      return results;
    } else if (angular.isDefined(watcher)) {
      return unwatchers.push(watcher);
    }
  };
  validateCtrlNames = function(formCtrl, modelCtrl) {
    if (!modelCtrl.$name) {
      throw 'missing attribute \'name\'';
    }
    if (!formCtrl.$name) {
      throw 'missing attribute \'name\' on parent form element';
    }
  };
  bindValidatorsAndCreateMessageContainer = function(scope, element, formCtrl, modelCtrl, attrs) {
    var arr, i, item, len, messageContainerElement, watcher;
    messageContainerElement = messageContainerFactory.beginContainer(formCtrl.$name, modelCtrl.$name);
    arr = validateAttributeHelper.toObject(attrs);
    for (i = 0, len = arr.length; i < len; i++) {
      item = arr[i];
      watcher = $injector.get(item.key).link(scope, modelCtrl, item.value);
      addWatcher(watcher);
      messageContainerElement += messageContainerFactory.createMessageFromItem(item);
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
      return scope.$on('$destroy', function() {
        var i, len, results, unwatch;
        results = [];
        for (i = 0, len = unwatchers.length; i < len; i++) {
          unwatch = unwatchers[i];
          results.push(unwatch());
        }
        return results;
      });
    }
  };
}]);

angular.module('slick-angular-validation').factory('dateHelper', function() {
  return {
    isValid: function(date) {
      if (Object.prototype.toString.call(date) !== "[object Date]") {
        return false;
      }
      return !isNaN(date.getTime());
    }
  };
});

angular.module('slick-angular-validation').factory('messageContainerFactory', ["SlickAngularValidation", "valueHelper", function(SlickAngularValidation, valueHelper) {
  var getMessage;
  getMessage = function(item) {
    var messageObj;
    if (item.customMessage) {
      return item.customMessage;
    }
    messageObj = SlickAngularValidation.getMessage(item.key);
    if (valueHelper.isModel(item.value)) {
      return messageObj.message.replace('#argument', '{{' + item.value + '}}');
    } else {
      return messageObj.message.replace('#argument', item.value);
    }
  };
  return {
    beginContainer: function(formCtrlName, modelCtrlName) {
      return '<ul ng-messages="' + formCtrlName + '.' + modelCtrlName + '.$error" class="slick-angular-validation-messages">';
    },
    createMessageFromItem: function(item) {
      return '<li ng-message="' + item.key + '">' + getMessage(item) + '</li>';
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
    if (attrs.validateMessages) {
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
  var startsWithDigit;
  startsWithDigit = function(val) {
    return /^[0-9]+/.test(val);
  };
  return {
    isModel: function(val) {
      if (startsWithDigit(val)) {
        return false;
      }
      return !/^\'|\'$/.test(val);
    },
    getValue: function(scope, isModel, val) {
      if (isModel) {
        return $parse(val)(scope);
      }
      if (startsWithDigit(val)) {
        return val;
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
      message: 'should be different to #argument'
    },
    differenti: {
      message: 'should be different to #argument'
    },
    email: {
      message: 'is not a valid email'
    },
    instring: {
      message: 'cannot be found within #argument'
    },
    instringi: {
      message: 'cannot be found within #argument'
    },
    match: {
      message: 'must match #argument'
    },
    matchi: {
      message: 'must match #argument'
    },
    max: {
      message: 'cannot be greater than #argument'
    },
    maxdate: {
      message: 'should be less than #argument'
    },
    maxlength: {
      message: 'cannot exceed #argument characters'
    },
    min: {
      message: 'cannot be less than #argument'
    },
    mindate: {
      message: 'should be greater than #argument'
    },
    minlength: {
      message: 'cannot be less than #argument characters'
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
  this.setMessage = function(key, message) {
    return this.messages[key] = {
      message: message
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
        viewVal = viewValue.toString().toLowerCase();
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

angular.module('slick-angular-validation').factory('alphanumeric', function() {
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
    link: function(scope, ctrl, argument) {
      var isModel;
      isModel = valueHelper.isModel(argument);
      ctrl.$validators.different = function(modelValue, viewValue) {
        var otherValue;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        otherValue = valueHelper.getValue(scope, isModel, argument);
        return viewValue !== otherValue;
      };
      if (isModel) {
        return scope.$watch(argument, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('differenti', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, otherNgModelName) {
      var isModel;
      isModel = valueHelper.isModel(otherNgModelName);
      ctrl.$validators.differenti = function(modelValue, viewValue) {
        var otherValue;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        otherValue = valueHelper.getValue(scope, isModel, otherNgModelName);
        return viewValue.toLowerCase() !== otherValue.toLowerCase();
      };
      if (isModel) {
        return scope.$watch(otherNgModelName, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('email', function() {
  return {
    link: function(scope, ctrl) {
      ctrl.$validators.email = function(modelValue, viewValue) {
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
        return value.indexOf(viewValue) !== -1;
      };
      if (isModel) {
        return scope.$watch(haystack, function() {
          return ctrl.$validate();
        });
      }
    }
  };
}]);

angular.module('slick-angular-validation').factory('instringi', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, haystack) {
      var isModel;
      isModel = valueHelper.isModel(haystack);
      ctrl.$validators.instringi = function(modelValue, viewValue) {
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

angular.module('slick-angular-validation').factory('matchi', ["valueHelper", function(valueHelper) {
  return {
    link: function(scope, ctrl, otherNgModelName) {
      var isModel;
      isModel = valueHelper.isModel(otherNgModelName);
      ctrl.$validators.matchi = function(modelValue, viewValue) {
        var otherValue;
        if (ctrl.$isEmpty(modelValue)) {
          return true;
        }
        otherValue = valueHelper.getValue(scope, isModel, otherNgModelName);
        return viewValue.toLowerCase() === otherValue.toLowerCase();
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
        maxlen = parseInt(valueHelper.getValue(scope, isModel, maxlength));
        if (isNaN(maxlen)) {
          return true;
        }
        return viewValue.length <= maxlen;
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
        minlen = parseInt(valueHelper.getValue(scope, isModel, minlength));
        if (isNaN(minlen)) {
          return true;
        }
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
      watchers = [];
      valueParts = otherValue.split('=');
      if (valueParts.length === 2) {
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
        if (part1IsModel) {
          watchers.push(scope.$watch(valueParts[1], function() {
            return ctrl.$validate();
          }));
        }
      } else {
        ctrl.$validators.requiredif = function(modelValue, viewValue) {
          var value0;
          value0 = valueHelper.getValue(scope, isModel, valueParts[0]);
          if (value0.length > 0 && ctrl.$isEmpty(modelValue)) {
            return false;
          }
          return true;
        };
      }
      watchers.push(scope.$watch(valueParts[0], function() {
        return ctrl.$validate();
      }));
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
