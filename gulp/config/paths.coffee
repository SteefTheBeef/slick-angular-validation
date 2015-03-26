b = 'build/'
d = 'dist/'

obj =
  build:
    directories:
      base: b
      js: b + 'app/'
      vendor: b + 'vendor/'
  dist: 'dist/'
  vendor: [
    'bower_components/jquery/dist/jquery.js'
    'bower_components/angular/angular.js'
    'bower_components/angular-messages/angular-messages.js'
  ]
  coffee:
    base: 'src/'
    build: [
      'src/config/registerModulesForBuild.coffee'
      'src/common/**/*.coffee'
      'src/**/*.coffee'
      'src/app.coffee'
      '!src/**/*.spec.*'
    ]
    compile: [
      'src/config/registerModulesForCompile.coffee'
      'src/common/**/*.coffee'
      '!src/app.coffee'
      '!src/**/*.spec.*'
    ]
  inject: {}
  index: './index.html'
  html:
    watch: 'src/**/*'
    files: './src/**/*.html'
    tpl: 'src/**/*.tpl.html'

obj.inject.vendor = () ->
  obj.vendor.map (filename) -> filename.replace('bower_components/', obj.build.directories.vendor)

obj.inject.coffeeToJs = () ->
  obj.coffee.files.map (filename) -> obj.build.directories.base + filename.replace('.coffee', '.js')

module.exports = obj

