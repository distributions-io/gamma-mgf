'use strict';

// FUNCTIONS //

var pow = Math.pow;


// PARTIAL //

/**
* FUNCTION: partial( alpha, beta )
*	Partially applies shape parameter `alpha` and rate parameter `beta` and returns a function for evaluating the moment-generating function (MGF) for a gamma distribution.
*
* @param {Number} alpha - shape parameter
* @param {Number} beta - rate parameter
* @returns {Function} MGF
*/
function partial( alpha, beta ) {

	/**
	* FUNCTION: mgf( t )
	*	Evaluates the moment-generating function (MGF) for a gamma distribution.
	*
	* @private
	* @param {Number} t - input value
	* @returns {Number} evaluated MGF
	*/
	return function mgf( t ) {
		var base;
		if ( t < beta ) {
			base = 1 - t / beta;
			return pow( base, -alpha );
		} else {
			return NaN;
		}
	};
} // end FUNCTION partial()


// EXPORTS //

module.exports = partial;
