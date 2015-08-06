Moment-Generating Function
===
[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url] [![Coverage Status][codecov-image]][codecov-url] [![Dependencies][dependencies-image]][dependencies-url]

> [Gamma](https://en.wikipedia.org/wiki/gamma_distribution) distribution moment-generating function (MGF).

The [moment-generating function](https://en.wikipedia.org/wiki/Moment-generating_function) for a [gamma](https://en.wikipedia.org/wiki/gamma_distribution) random variable is

<div class="equation" align="center" data-raw-text="
	M_X(t) := \mathbb{E}\!\left[e^{tX}\right] = \left( 1 - \frac{t}{\beta} \right)^{-\alpha}" data-equation="eq:mgf_function">
	<img src="" alt="Moment-generating function (MGF) for a gamma distribution.">
	<br>
</div>

where `alpha` is the shape parameter and `beta` is the rate parameter. For `t >= beta`, the MGF is not defined and this module returns `NaN`.

## Installation

``` bash
$ npm install distributions-gamma-mgf
```

For use in the browser, use [browserify](https://github.com/substack/node-browserify).


## Usage

``` javascript
var mgf = require( 'distributions-gamma-mgf' );
```

#### mgf( t[, options] )

Evaluates the [moment-generating function](https://en.wikipedia.org/wiki/Moment-generating_function) (MGF) for the [gamma](https://en.wikipedia.org/wiki/gamma_distribution) distribution. `t` may be either a [`number`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number), an [`array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array), a [`typed array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays), or a [`matrix`](https://github.com/dstructs/matrix).

``` javascript
var matrix = require( 'dstructs-matrix' ),
	mat,
	out,
	t,
	i;

out = mgf( -1 );
// returns 0.5

out = mgf( 1 );
// returns NaN

t = [ 0, 0.2, 0.4, 0.6, 0.8, 1 ];
out = mgf( t );
// returns [ 1, 1.25, ~1.667, 2.5, 5, NaN ]

t = new Int8Array( t );
out = mgf( t );
// returns Float64Array( [1,1,~1.667,~1.667,5,5] )

t = new Float32Array( 6 );
for ( i = 0; i < 6; i++ ) {
	t[ i ] = i / 6;
}
mat = matrix( t, [3,2], 'float32' );
/*
	[  0   1/6
	  2/6  3/6
	  4/6  5/6 ]
*/

out = mgf( mat );
/*
	[ ~1   ~1.2
	  ~1.5 ~2
	  ~3   ~6 ]
*/
```

The function accepts the following `options`:

*	__alpha__: shape parameter. Default: `1`.
*	__beta__: rate parameter. Default: `1`.
* 	__accessor__: accessor `function` for accessing `array` values.
* 	__dtype__: output [`typed array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays) or [`matrix`](https://github.com/dstructs/matrix) data type. Default: `float64`.
*	__copy__: `boolean` indicating if the `function` should return a new data structure. Default: `true`.
*	__path__: [deepget](https://github.com/kgryte/utils-deep-get)/[deepset](https://github.com/kgryte/utils-deep-set) key path.
*	__sep__: [deepget](https://github.com/kgryte/utils-deep-get)/[deepset](https://github.com/kgryte/utils-deep-set) key path separator. Default: `'.'`.

A [gamma](https://en.wikipedia.org/wiki/gamma_distribution) distribution is a function of 2 parameter(s): `alpha`(shape parameter) and `beta`(rate parameter). By default, `alpha` is equal to `1` and `beta` is equal to `1`. To adjust either parameter, set the corresponding option.

``` javascript
var t = [ 0, 0.2, 0.4, 0.6, 0.8, 1 ];

var out = mgf( t, {
	'alpha': 2,
	'beta': 4
});
// returns [ 1, ~1.108, ~1.235, ~1.384, ~1.562, ~1.778 ]
```

For non-numeric `arrays`, provide an accessor `function` for accessing `array` values.

``` javascript
var data = [
	[0,0],
	[1,0.2],
	[2,0.4],
	[3,0.6],
	[4,0.8],
	[5,1]
];

function getValue( d, i ) {
	return d[ 1 ];
}

var out = mgf( data, {
	'accessor': getValue
});
// returns [ 1, 1.25, ~1.667, 2.5, 5, NaN ]
```


To [deepset](https://github.com/kgryte/utils-deep-set) an object `array`, provide a key path and, optionally, a key path separator.

``` javascript
var data = [
	{'x':[0,0]},
	{'x':[1,0.2]},
	{'x':[2,0.4]},
	{'x':[3,0.6]},
	{'x':[4,0.8]},
	{'x':[5,1]}
];

var out = mgf( data, {
	'path': 'x/1',
	'sep': '/'
});
/*
	[
		{'x':[0,1]},
		{'x':[1,1.25]},
		{'x':[2,~1.667]},
		{'x':[3,2.5]},
		{'x':[4,5]},
		{'x':[5,NaN]}
	]
*/

var bool = ( data === out );
// returns true
```

By default, when provided a [`typed array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Typed_arrays) or [`matrix`](https://github.com/dstructs/matrix), the output data structure is `float64` in order to preserve precision. To specify a different data type, set the `dtype` option (see [`matrix`](https://github.com/dstructs/matrix) for a list of acceptable data types).

``` javascript
var t, out;

t = new Int8Array( [0,1,2,3,4] );

out = mgf( t, {
	'alpha': 2,
	'beta': 5,
	'dtype': 'int32'
});
// returns Int32Array( [1,1,2,6,25] )

// Works for plain arrays, as well...
out = mgf( [0,1,2,3,4], {
	'alpha': 2,
	'beta': 5,
	'dtype': 'uint8'
});
// returns Uint8Array( [1,1,2,6,25] )
```

By default, the function returns a new data structure. To mutate the input data structure (e.g., when input values can be discarded or when optimizing memory usage), set the `copy` option to `false`.

``` javascript
var bool,
	mat,
	out,
	t,
	i;

t = [ 0, 0.2, 0.4, 0.6, 0.8, 1 ];

out = mgf( t, {
	'copy': false
});
// returns [ 1, 1.25, ~1.667, 2.5, 5, NaN ]

bool = ( t === out );
// returns true

t = new Float32Array( 6 );
for ( i = 0; i < 6; i++ ) {
	t[ i ] = i / 6;
}
mat = matrix( t, [3,2], 'float32' );
/*
	[  0   1/6
	  2/6  3/6
	  4/6  5/6 ]
*/

out = mgf( mat, {
	'copy': false
});
/*
	[ ~1   ~1.2
	  ~1.5 ~2
	  ~3   ~6 ]
*/

bool = ( mat === out );
// returns true
```


## Notes

*	If an element is __not__ a numeric value, the evaluated [MGF](https://en.wikipedia.org/wiki/gamma_distribution) is `NaN`.

	``` javascript
	var data, out;

	out = mgf( null );
	// returns NaN

	out = mgf( true );
	// returns NaN

	out = mgf( {'a':'b'} );
	// returns NaN

	out = mgf( [ true, null, [] ] );
	// returns [ NaN, NaN, NaN ]

	function getValue( d, i ) {
		return d.x;
	}
	data = [
		{'x':true},
		{'x':[]},
		{'x':{}},
		{'x':null}
	];

	out = mgf( data, {
		'accessor': getValue
	});
	// returns [ NaN, NaN, NaN, NaN ]

	out = mgf( data, {
		'path': 'x'
	});
	/*
		[
			{'x':NaN},
			{'x':NaN},
			{'x':NaN,
			{'x':NaN}
		]
	*/
	```

*	Be careful when providing a data structure which contains non-numeric elements and specifying an `integer` output data type, as `NaN` values are cast to `0`.

	``` javascript
	var out = mgf( [ true, null, [] ], {
		'dtype': 'int8'
	});
	// returns Int8Array( [0,0,0] );
	```


## Examples

``` javascript
var mgf = require( 'distributions-gamma-mgf' ),
	matrix = require( 'dstructs-matrix' );

var data,
	mat,
	out,
	tmp,
	i;

// Plain arrays...
data = new Array( 10 );
for ( i = 0; i < data.length; i++ ) {
	data[ i ] = i / 10;
}
out = mgf( data );

// Object arrays (accessors)...
function getValue( d ) {
	return d.x;
}
for ( i = 0; i < data.length; i++ ) {
	data[ i ] = {
		'x': data[ i ]
	};
}
out = mgf( data, {
	'accessor': getValue
});

// Deep set arrays...
for ( i = 0; i < data.length; i++ ) {
	data[ i ] = {
		'x': [ i, data[ i ].x ]
	};
}
out = mgf( data, {
	'path': 'x/1',
	'sep': '/'
});

// Typed arrays...
data = new Float32Array( 10 );
for ( i = 0; i < data.length; i++ ) {
	data[ i ] = i / 10;
}
out = mgf( data );

// Matrices...
mat = matrix( data, [5,2], 'float32' );
out = mgf( mat );

// Matrices (custom output data type)...
out = mgf( mat, {
	'dtype': 'uint8'
});
```

To run the example code from the top-level application directory,

``` bash
$ node ./examples/index.js
```


## Tests

### Unit

Unit tests use the [Mocha](http://mochajs.org/) test framework with [Chai](http://chaijs.com) assertions. To run the tests, execute the following command in the top-level application directory:

``` bash
$ make test
```

All new feature development should have corresponding unit tests to validate correct functionality.


### Test Coverage

This repository uses [Istanbul](https://github.com/gotwarlost/istanbul) as its code coverage tool. To generate a test coverage report, execute the following command in the top-level application directory:

``` bash
$ make test-cov
```

Istanbul creates a `./reports/coverage` directory. To access an HTML version of the report,

``` bash
$ make view-cov
```


---
## License

[MIT license](http://opensource.org/licenses/MIT).


## Copyright

Copyright &copy; 2015. The [Compute.io](https://github.com/compute-io) Authors.


[npm-image]: http://img.shields.io/npm/v/distributions-gamma-mgf.svg
[npm-url]: https://npmjs.org/package/distributions-gamma-mgf

[travis-image]: http://img.shields.io/travis/distributions-io/gamma-mgf/master.svg
[travis-url]: https://travis-ci.org/distributions-io/gamma-mgf

[codecov-image]: https://img.shields.io/codecov/c/github/distributions-io/gamma-mgf/master.svg
[codecov-url]: https://codecov.io/github/distributions-io/gamma-mgf?branch=master

[dependencies-image]: http://img.shields.io/david/distributions-io/gamma-mgf.svg
[dependencies-url]: https://david-dm.org/distributions-io/gamma-mgf

[dev-dependencies-image]: http://img.shields.io/david/dev/distributions-io/gamma-mgf.svg
[dev-dependencies-url]: https://david-dm.org/dev/distributions-io/gamma-mgf

[github-issues-image]: http://img.shields.io/github/issues/distributions-io/gamma-mgf.svg
[github-issues-url]: https://github.com/distributions-io/gamma-mgf/issues
