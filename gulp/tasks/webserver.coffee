gulp = require 'gulp'
streamify = require('gulp-streamify')
webserver = require 'gulp-webserver'

module.exports = (root) ->
  gulp.src(root)
  .pipe(webserver({
    livereload: false,
    directoryListing: false,
    open: true
  }))


