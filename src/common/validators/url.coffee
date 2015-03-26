angular.module('slick-angular-validation')
.factory 'url', () ->
  # Regular Expression for URL validation
  #
  # Author: Diego Perini
  # Updated: 2010/12/05
  # License: MIT
  #
  # Copyright (c) 2010-2013 Diego Perini (http://www.iport.it)
  #
  # Permission is hereby granted, free of charge, to any person
  # obtaining a copy of this software and associated documentation
  # files (the "Software"), to deal in the Software without
  # restriction, including without limitation the rights to use,
  # copy, modify, merge, publish, distribute, sublicense, and/or sell
  # copies of the Software, and to permit persons to whom the
  # Software is furnished to do so, subject to the following
  urlRegex = /^(?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/i

  {
    link: (scope, ctrl) ->
      ctrl.$validators.url = (modelValue, viewValue) ->
        if ctrl.$isEmpty(modelValue) then return true

        urlRegex.test(viewValue)

      return
  }