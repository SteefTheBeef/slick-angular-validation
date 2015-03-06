gulp = require 'gulp'
templateCache = require('gulp-angular-templatecache');
streamify = require('gulp-streamify')

module.exports = (sourceFiles, dest) ->
  gulp.src(sourceFiles)
  .pipe(templateCache('templates.js', { root: '/src/' }))
  .pipe(gulp.dest(dest));