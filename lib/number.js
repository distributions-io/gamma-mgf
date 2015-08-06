'use strict';

// FUNCTIONS //

var pow = Math.pow;


// MGF //

/**
* FUNCTION: mgf( x, alpha, beta )
*	Evaluates the moment-generating function (MGF) for a gamma distribution with shape parameter `alpha` and rate parameter `beta` at a value `t`.
*
* @param {Number} t - input value
* @param {Number} alpha - shape parameter
* @param {Number} beta - rate parameter
* @returns {Number} evaluated MGF
*/
function mgf( t, alpha, beta ) {
	var base;
	if ( t < beta ) {
		base = 1 - t / beta;
		return pow( base, -alpha );
	} else {
		return NaN;
	}
} // end FUNCTION mgf()


// EXPORTS //

module.exports = mgf;
