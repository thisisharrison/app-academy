const curry = require('./arguments.js');


function sumThree(num1, num2, num3) {
    total = num1 + num2 + num3;
    console.log(total);
    return total;
}


let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30

// or more briefly:
sumThree.curry(3)(4)(20)(6); // == 30