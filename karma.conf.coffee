module.exports = (config) ->
  config.set
    preprocessors: {
      '**/*.coffee': ['coffee']
    },
    coffeePreprocessor: {
      options: {
        bare: true,
        sourceMap: false
      },
      transformPath: (path) ->
        path.replace(/\.coffee$/, '.js')
    }
    basePath: ''
    files: [
      'bower_components/angular/angular.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'src/registerModules.coffee'
      'src/*.coffee'
      'src/rules/*.coffee'
      'test/rules/*.spec.coffee'

    ],
    frameworks: ['jasmine']
    browsers: ['PhantomJS']
    port: 9876,
    captureTimeout: 20000,
    singleRun: false,
    reportSlowerThan: 500
    LogLevel: config.LOG_DEBUG,
    plugins: [
      'karma-jasmine',
      'karma-chrome-launcher'
      'karma-phantomjs-launcher'
      'karma-coffee-preprocessor'
    ]
