gulp = require 'gulp'
paths = require '../config/paths.coffee'

module.exports = () ->
  console.log 'Watching for .coffee, .less and .html file changes.'
  gulp.task 'b-watchCoffee', -> require('./coffee.coffee')(paths.coffee.files, paths.build.directories.base)
  gulp.watch(paths.coffee.base + '/**/*', ['b-watchCoffee'])
  gulp.task 'b-watchLess', -> require('./less.coffee')(paths.less.build, paths.build.directories.css)
  gulp.watch(paths.less.base + '/**/*', ['b-watchLess'])
  gulp.task 'b-watchHtml', -> require('./copyHtml.coffee')(paths.html.files, paths.build.directories.base)
  gulp.watch(paths.html.watch + '/**/*', ['b-watchHtml'])