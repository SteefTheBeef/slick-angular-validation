gulp = require 'gulp'
paths = require './gulp/config/paths.coffee'

general =
  clean: (directory, callback) -> require('./gulp/tasks/clean.coffee')(directory, callback)
  concat: (sourceFiles, filename, dest) -> require('./gulp/tasks/concat.coffee')(sourceFiles, filename, dest)
  test: () -> require('./gulp/tasks/test.coffee')(paths.vendor)
  webserver: (serverRoot) -> require('./gulp/tasks/webserver.coffee')(serverRoot)
  templateCache: (sourceFiles, dest) -> require('./gulp/tasks/templateCache.coffee')(sourceFiles, dest)

build =
  copyVendor: () -> require('./gulp/tasks/copyVendor.coffee')(paths.vendor, paths.build.directories.base)
  coffee: () -> require('./gulp/tasks/coffee.coffee')(paths.coffee.files, paths.build.directories.base)
  inject: () -> require('./gulp/tasks/injectBuild.coffee')(paths.index, paths.inject.coffeeToJs(), paths.vendor, paths.inject.lessToCss(), paths.build.directories.base)
  webserver: () -> require('./gulp/tasks/webserver.coffee')(paths.build.directories.base)

compile =
  minifyJS: () -> require('./gulp/tasks/minifyJS.coffee')(paths.vendor, 'vendor.js', paths.dist.directories.tmp)
  minifyCoffeeToJs: () -> require('./gulp/tasks/minifyCoffeeToJs.coffee')(paths.coffee.compile, 'slick-angular-validation', paths.dist)

# Test tasks
gulp.task 'test', () -> general.test()

# Build tasks
gulp.task 'b-clean', (callback) -> general.clean(paths.build.directories.base, callback)
gulp.task 'b-copyVendor', ['b-clean'], () -> build.copyVendor()
gulp.task 'b-coffee', ['b-clean'], () -> build.coffee()
gulp.task 'b-inject', ['b-clean', 'b-copyVendor', 'b-coffee'], () -> build.inject()
gulp.task 'b-webserver', ['b-clean', 'b-copyVendor', 'b-coffee', 'b-inject'], () -> general.webserver(paths.build.directories.base)
gulp.task 'build', ['b-clean', 'b-copyVendor', 'b-coffee', 'b-inject','b-less', 'b-webserver'], () ->
  require('./gulp/tasks/buildWatch.coffee')(paths.coffee, paths.build.directories.js)

# compile tasks
gulp.task 'c-clean', (callback) -> general.clean(paths.dist, callback)
gulp.task 'c-minifyCoffeeToJS', ['c-clean'], () -> compile.minifyCoffeeToJs()
gulp.task 'compile', ['c-clean', 'c-minifyCoffeeToJS'], () ->


