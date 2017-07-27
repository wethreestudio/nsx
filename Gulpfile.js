var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var watch = require('gulp-watch');
var postcss = require('gulp-postcss');
var autoprefixer = require('autoprefixer');
var uncss = require('postcss-uncss');
var cssnano = require('cssnano');
var clean = require('gulp-clean');
var browserSync = require('browser-sync').create();

gulp.task('clean', function() {
	return gulp
		.src('./build/**/*.html', {read: false})
        .pipe(clean());
});

gulp.task('copy', ['clean'], function () {
    return gulp
    	.src('./src/**/*.html')
        .pipe(gulp.dest('./build'));
});

gulp.task('sass', ['copy'], function () {
	var plugins = [
        autoprefixer({
            browsers: ['last 2 versions']
        }),
        cssnano()//,
        //uncss({
        //    html: ['./build/**/*.html'],
        //    stylesheets: ['./build/css/main.css'],
        //    ignore: [/\.blue-back/, /\.visible-search/]
        //})
    ];
    return gulp
		.src('./src/styling/main.scss')
		.pipe(sourcemaps.init())
		.pipe(sass({
			errLogToConsole: true,
			outputStyle: 'expanded'
		}).on('error', sass.logError))
		.pipe(sourcemaps.write())
        .pipe(postcss(plugins))
		.pipe(gulp.dest('./build/css'));
});

gulp.task('browser-sync', function() {
    browserSync.init({
        server: {
            baseDir: "./build",
            directory: true,
            middleware: function (req, res, next) {
                res.setHeader('Access-Control-Allow-Origin', '*');
                next();
            }
        }
    });
});

// Static Server + watching scss/html files
gulp.task('serve', ['clean', 'copy', 'sass'], function() {
    browserSync.init({
        server: "./build"
    });

    gulp.watch("./src/styling/*.scss", ['sass']);
    gulp.watch("./src/styling/**/*.scss", ['sass']);
    gulp.watch("./src/**/*.html", ['clean', 'copy']);
});

gulp.task('default', ['serve']);

var gulp        = require('gulp');
var browserSync = require('browser-sync').create();