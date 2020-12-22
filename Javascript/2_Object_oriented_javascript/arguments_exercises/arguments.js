// SUM
function sum1 () {
    let total = 0;

    for (let i = 0; i < arguments.length; i++) {
        total += arguments[i];
    }

    return total;
}

function sum2 (...nums) {
    return nums.reduce((acc, num) => acc += num);
}

// console.log(sum2(1, 2, 3, 4) === 10);
// console.log(sum2(1, 2, 3, 4, 5) === 15);

// BIND WITH ARGS
Function.prototype.myBind1 = function (newThis) {
    let bindArgs = Array.from(arguments).slice(1);
    const orgThis = this;
    return function callTime () {
        const callArgs = Array.from(arguments);
        return orgThis.apply(newThis, bindArgs.concat(callArgs));
    };
}
// newThis = the new 'this' in binding
// orgThis = the org 'this', the instance calling the function
// bindArgs = args in bind function
// callArgs = args in original function

Function.prototype.myBind = function (newThis, ...bindArgs) {
    return (...callArgs) => this.apply(newThis, bindArgs.concat(callArgs));
}

module.exports = Function.prototype.myBind;

// CURRIED SUM
Function.prototype.curriedSum = function (numArgs) {
    // Collect arguments
    const numbers = [];
    function _curriedSum(num) {
        numbers.push(num);
        if (numbers.length === numArgs) {
            // numArgs reached, do the work
            return numbers.reduce((acc, num) => acc += num);
        } else {
            // return itself unti numArgs reached
            return _curriedSum;
        }
    }
    return _curriedSum;
}

module.exports = Function.prototype.curriedSum;

// CURRY
// use apply
Function.prototype.curry = function (numArgs) {
    const numbers = [];
    const orgFn = this;

    function _curryFn(num) {
        numbers.push(num);

        if (numbers.length === numArgs) {
            // 'this' is null. Calling sumThree does not need 'this'
            orgFn.apply(null, numbers);
        } else {
            return _curryFn;
        }
    }

    return _curryFn;
}

// use spread
Function.prototype.curry1 = function (numArgs) {
    // Collect arguments
    const numbers = [];
    // Copy of original function, sumThree
    const orgFn = this;

    function _curryFn(num) {
        numbers.push(num);

        if (numbers.length === numArgs) {
            // Call the original function
            orgFn(...numbers);
        } else {
            // Return self if too few
            return _curryFn;
        }
    }

    return _curryFn;
}

module.exports = Function.prototype.curry;