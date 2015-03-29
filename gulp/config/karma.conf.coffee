module.exports = (config) ->
  config.set
    preprocessors: {
      '../../src/**/*.coffee': ['coffee']
    },
    coffeePreprocessor: {
      options: {
        bare: true,
        sourceMap: false
      },
      transformPath: (path) ->
        path.replace(/\.coffee$/, '.js')
    }
    browserify: {
      transform: ['coffeeify']

      # don't forget to register the extensions
      extensions: ['.js', '.jsx', '.coffee']
    }
    basePath: ''
    files: [
      '../../bower_components/angular/angular.js'
      '../../bower_components/angular-messages/angular-messages.js'
      '../../bower_components/angular-mocks/angular-mocks.js'
      '../../src/config/registerModulesForBuild.coffee'
      '../../src/common/helpers/*.coffee'
      '../../src/common/validators/*.coffee'
      #'../../src/**/*.coffee'
      '../../src/tests/validators/ValidatorTestHelper.coffee'
      '../../src/**/*.spec.coffee'
    ],
    frameworks: ['jasmine']
    browsers: ['Chrome']
    port: 9876,
    captureTimeout: 20000,
    singleRun: false,
    reportSlowerThan: 500
    LogLevel: config.LOG_DEBUG,
    plugins: [
      'karma-jasmine'
      'karma-chrome-launcher'
      'karma-phantomjs-launcher'
      'karma-coffee-preprocessor'
    ]
