gulp = require 'gulp'
paths = require '../config/paths.coffee'

module.exports = () ->
  console.log 'Watching for .coffee, .less and .html file changes.'

  gulp.task 'b-watchHtml', -> require('./copyHtml.coffee')(paths.html.files, paths.build.directories.base)
  gulp.watch(paths.html.watch + '/**/*', ['b-watchHtml'])

  gulp.task 'index', ['coffee', 'less'] ,-> require('./injectBuild.coffee')(paths.index, paths.inject.coffeeToJs(), paths.vendor, paths.inject.lessToCss(), paths.build.directories.base)
  gulp.watch(paths.index, ['index'])

  gulp.task 'coffee', -> require('./coffee.coffee')(paths.coffee.files, paths.build.directories.base)
  gulp.task 'indexInjectCoffee', ['coffee'] ,-> require('./injectBuild.coffee')(paths.index, paths.inject.coffeeToJs(), paths.vendor, paths.inject.lessToCss(), paths.build.directories.base)
  gulp.watch(paths.coffee.base + '/**/*', ['indexInjectCoffee'])
