gulp = require 'gulp'
del = require 'del'
util = require 'gulp-util'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
ngAnnotate = require 'gulp-ng-annotate'
uglify = require 'gulp-uglify'
karma = require 'gulp-karma'


files = require './config/files.coffee'

registerWatcherOnChangeConsole = (watcher) ->
  watcher.on 'change', (event) ->
    console.log('File '+event.path+' was '+event.type+', running tasks...')

obj = {
  clean: (done) ->
    del ['build/**'], () ->
      done()

  coffee: (done) ->
    gulp.src(['./src/{,*/}*.coffee'])
    .pipe(coffee({ bare: true }))
    .pipe(ngAnnotate())
    .pipe(gulp.dest('./build/'))
    .on 'end', () ->
      done()
    # do not return the stream, otherwise the callback hack for sequential tasks does not work.
    true

  compile: () ->
    gulp.src(files.build.js)
    .pipe(concat('slick-angular-validation.js'))
    .pipe(gulp.dest('./dist/'))
    .on 'error', (err) ->

    gulp.src(files.build.js)
    .pipe(concat('slick-angular-validation.min.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./dist/'))
    .on 'error', (err) ->

  test: () ->
    gulp.src('./bajs')
    .pipe(karma({
      configFile: 'karma.conf.coffee',
      action: 'run'
    }))
    .on 'error', (err) ->
      #throw err;

  registerWatchers: () ->
    gulp.task 'b-watchCoffee', => @coffee()
    coffeeWatcher = gulp.watch('./src/{,*/}*.coffee', ['b-watchCoffee']);

    registerWatcherOnChangeConsole(coffeeWatcher)
}

gulp.task 'concat', => obj.concat()
gulp.task 'b-clean', => (callback) -> obj.clean(callback)
gulp.task 'b-coffee', ['b-clean'], (callback) -> obj.coffee(callback)
gulp.task 'test', () => obj.test()
gulp.task 'compile', => obj.compile()

gulp.task 'build', ['b-clean', 'b-coffee'], =>
  obj.registerWatchers()


