gulp = require 'gulp'
karma = require 'gulp-karma'
k = require 'karma-browserify'
streamify = require('gulp-streamify')

module.exports = () ->
  # put some bogus path here to trick it into
  # using the paths in karma.conf.coffee instead.

  gulp.src('./bogus')
  .pipe(karma({ configFile: './gulp/config/karma.conf.coffee', action: 'run' }))
