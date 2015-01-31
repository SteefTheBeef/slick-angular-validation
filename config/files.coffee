module.exports =
  src:
    coffee: [
      'validate.coffee',
    ]
    js: [
      'build/src/common/config/appConfig.js',
    ]
  vendor:
    js: [
      'angular/angular.js',
    ]
  test:
    [
      #'test/required.spec.coffee'
      'test/required.spec.js'
    ]
  build:
    js: [
      'build/registerModules.js'
      'build/rules/*.js'
      'build/rules.js'
      'build/validationElementFactory.js'
      'build/validate.js'
    ]

