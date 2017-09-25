var packageJSON = require('./package.json')

var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var watch = require('gulp-watch');
var postcss = require('gulp-postcss');
var autoprefixer = require('autoprefixer');
var uncss = require('postcss-uncss');
var cssnano = require('cssnano');
var clean = require('gulp-clean');
var replace = require('gulp-replace');
var browserSync = require('browser-sync').create();

var isDev = process.env.NODE_ENV === 'production' ? false : true;
var PATH = isDev ? 'http://localhost:3000/' : packageJSON.previewPath;

gulp.task('clean', function() {
	return gulp
		.src(['./build/**/*.html'], {read: false})
		.pipe(clean());
});

gulp.task('copy-html', ['copy-fonts'], function () {
	return gulp
		.src(['./src/**/*.html'])
		.pipe(gulp.dest('./build'));
});

gulp.task('copy-fonts', ['clean'], function () {
	return gulp
		.src(['./src/fonts/*.*'])
		.pipe(gulp.dest('./build/fonts'));
});

gulp.task('replace', ['copy-html'], function(){
	return gulp
		.src(['./build/**/*.html'])
		.pipe(replace('%%PATH%%', PATH))
		.pipe(gulp.dest('./build'));
});

gulp.task('sass', ['replace'], function () {
	var plugins = [
		autoprefixer({
			browsers: ['last 3 versions', 'ie > 9']
		})
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
		.pipe(gulp.dest('./build/css'))
		.pipe(browserSync.stream());
});

gulp.task('sass-build', ['copy-html'], function () {
	var plugins = [
		autoprefixer({
			browsers: ['last 3 versions', 'ie > 9']
		}),
		cssnano()
	];
	return gulp
		.src('./src/styling/main.scss')
		.pipe(sass({
			errLogToConsole: true,
			outputStyle: 'expanded'
		}).on('error', sass.logError))
		.pipe(postcss(plugins))
		.pipe(gulp.dest('./build/css'));
});

// Static Server + watching scss/html files
gulp.task('serve', ['clean', 'copy-fonts', 'copy-html', 'replace', 'sass'], function() {
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

	gulp.watch("./src/styling/**/*.scss", ['sass']);
	gulp.watch("./src/**/*.html", ['clean', 'copy-fonts', 'copy-html', 'replace']).on('change', browserSync.reload);
});

// Build and serve locally with watch and browsersync
gulp.task('default', ['serve']);

// Build for S3 hosting preview
gulp.task('build-preview', ['clean', 'copy-fonts', 'copy-html', 'replace', 'sass']);

// BBuild production files
gulp.task('build', ['clean', 'copy-fonts', 'copy-html', 'sass-build']);