gulp = require 'gulp'
paths = require './gulp/config/paths.coffee'

general =
  clean: (directory, callback) -> require('./gulp/tasks/clean.coffee')(directory, callback)
  concat: (sourceFiles, filename, dest) -> require('./gulp/tasks/concat.coffee')(sourceFiles, filename, dest)
  test: () -> require('./gulp/tasks/test.coffee')(paths.vendor)
  less: (sourceFiles, dest) -> require('./gulp/tasks/less.coffee')(sourceFiles, dest)
  webserver: (serverRoot) -> require('./gulp/tasks/webserver.coffee')(serverRoot)
  templateCache: (sourceFiles, dest) -> require('./gulp/tasks/templateCache.coffee')(sourceFiles, dest)

build =
  copyVendor: () -> require('./gulp/tasks/copyVendor.coffee')(paths.vendor, paths.build.directories.base)
  coffee: () -> require('./gulp/tasks/coffee.coffee')(paths.coffee.files, paths.build.directories.base)
  copyHtml: () -> require('./gulp/tasks/copyHtml.coffee')(paths.html.files, paths.build.directories.base)
  inject: () -> require('./gulp/tasks/injectBuild.coffee')(paths.index, paths.inject.coffeeToJs(), paths.vendor, paths.inject.lessToCss(), paths.build.directories.base)
  webserver: () -> require('./gulp/tasks/webserver.coffee')(paths.build.directories.base)

compile =
  minifyJS: () -> require('./gulp/tasks/minifyJS.coffee')(paths.vendor, 'vendor.js', paths.dist.directories.tmp)
  minifyCoffeeToJs: () -> require('./gulp/tasks/minifyCoffeeToJs.coffee')(paths.coffee.files, 'scripts.js', paths.dist.directories.tmp)
  inject: () -> require('./gulp/tasks/injectDist.coffee')(paths.index, 'dist/js/production.js', 'dist/css/production.css', paths.dist.directories.base)

# Test tasks
gulp.task 'test', () -> general.test()

# Build tasks
gulp.task 'b-clean', (callback) -> general.clean(paths.build.directories.base, callback)
gulp.task 'b-copyVendor', ['b-clean'], () -> build.copyVendor()
gulp.task 'b-coffee', ['b-clean'], () -> build.coffee()
gulp.task 'b-less', ['b-clean'], () -> general.less(paths.less.build,  paths.build.directories.css)
gulp.task 'b-copyHtml', ['b-clean'], () -> build.copyHtml()
gulp.task 'b-inject', ['b-clean', 'b-copyVendor', 'b-coffee'], () -> build.inject()
gulp.task 'b-webserver', ['b-clean', 'b-copyHtml', 'b-copyVendor', 'b-coffee', 'b-less', 'b-inject'], () -> general.webserver(paths.build.directories.base)
gulp.task 'build', ['b-clean', 'b-copyVendor', 'b-coffee', 'b-inject','b-less', 'b-webserver'], () ->
  require('./gulp/tasks/buildWatch.coffee')(paths.coffee, paths.build.directories.js)

# compile tasks
minifiedFiles = ['vendor.js', 'scripts.js', 'templates.js'].map (filename) -> paths.dist.directories.tmp + filename
gulp.task 'c-clean', (callback) -> general.clean(paths.dist.directories.base, callback)
gulp.task 'c-templateCache', ['c-clean'], () -> general.templateCache(paths.html.tpl, paths.dist.directories.tmp)
gulp.task 'c-minifyCoffeeToJS', ['c-clean'], () -> compile.minifyCoffeeToJs()
gulp.task 'c-minifyVendorJS', ['c-clean'], () -> compile.minifyJS()
gulp.task 'c-less', ['c-clean'], () -> general.less(paths.less.dist, paths.dist.directories.css)
gulp.task 'c-concat', ['c-clean', 'c-templateCache', 'c-minifyCoffeeToJS','c-minifyVendorJS'], () -> general.concat(minifiedFiles, 'production.js', paths.dist.directories.js)
gulp.task 'c-inject', ['c-clean', 'c-templateCache', 'c-minifyCoffeeToJS','c-minifyVendorJS', 'c-concat', 'c-less'], () -> compile.inject()
gulp.task 'c-webserver', ['c-clean', 'c-templateCache', 'c-minifyCoffeeToJS','c-minifyVendorJS', 'c-concat', 'c-less', 'c-inject'], () -> general.webserver(paths.dist.directories.base)

gulp.task 'compile', ['c-clean', 'c-templateCache', 'c-minifyCoffeeToJS','c-minifyVendorJS', 'c-concat', 'c-less', 'c-inject', 'c-webserver'], () ->


