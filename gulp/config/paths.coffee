b = 'build/'
d = 'dist/'
less = 'less/'

obj =
  build:
    directories:
      base: b
      js: b + 'app/'
      vendor: b + 'vendor/'
      css: b + 'css/'
  dist:
    directories:
      base: d
      tmp: d + '.tmp/'
      js: d + 'js/'
      css: d + 'css/'
  vendor: [
    'bower_components/jquery/dist/jquery.js'
    'bower_components/angular/angular.js'
    'bower_components/angular-animate/angular-animate.js'
    'bower_components/angular-resource/angular-resource.js'
    'bower_components/angular-sanitize/angular-sanitize.js'
    'bower_components/angular-ui-router/release/angular-ui-router.js'
    'bower_components/angular-strap/dist/angular-strap.js'
    'bower_components/angular-strap/dist/angular-strap.tpl.min.js'
  ]

  coffee:
    base: 'src/'
    files: [
      'src/config/registerModules.coffee'
      'src/common/**/*.coffee'
      'src/**/*.coffee'
      'src/app.coffee'
      '!src/**/*.spec.*'
    ]
  inject: {}
  less:
    base: less
    build: [
      '!' + less + 'production.less'
      less + '**/*.less'
    ]
    dist: './less/production.less'
  index: './index.html'
  html:
    watch: 'src/**/*'
    files: './src/**/*.html'
    tpl: 'src/**/*.tpl.html'
  browserify:
    bundleFilename: 'vendor.js'
obj.inject.vendor = () ->
  obj.vendor.map (filename) -> filename.replace('bower_components/', obj.build.directories.vendor)

obj.inject.coffeeToJs = () ->
  obj.coffee.files.map (filename) -> obj.build.directories.base + filename.replace('.coffee', '.js')

obj.inject.lessToCss = () ->
  obj.build.directories.css + '**/*.css'



module.exports = obj

