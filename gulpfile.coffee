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
  clean: () ->
    del ['build/**'], (err) ->
      console.log('Files deleted')

  coffee: (err) ->
    gulp.src(['./src/{,*/}*.coffee'])
    .pipe(coffee({ bare: true }))
    .pipe(ngAnnotate())
    .pipe(gulp.dest('./build/'))
    .on 'error', (err) ->
      console.log err

  compile: () ->
    gulp.src(files.build.js)
    .pipe(concat('angular-validate.min.js'))
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
    #gulp.task 'b-watchTemplates', => @templateCache()
    #gulp.task 'b-watchLess', => @less()

    coffeeWatcher = gulp.watch('./src/{,*/}*.coffee', ['b-watchCoffee']);
    #templateWatcher = gulp.watch('./src/**/*.html', ['b-watchTemplates']);
    #lessWatcher =  gulp.watch('./src/less/*.less', ['b-watchLess']);

    registerWatcherOnChangeConsole(coffeeWatcher)
}

gulp.task 'concat', => obj.concat()
gulp.task 'b-clean', => obj.clean()
gulp.task 'b-coffee', ['b-clean'], => obj.coffee()
gulp.task 'test', () => obj.test()
gulp.task 'compile', => obj.compile()

gulp.task 'build', ['b-clean', 'b-coffee'], =>
  obj.registerWatchers()


