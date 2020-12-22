const curriedSum = require('./arguments.js');


function sumThree(num1, num2, num3) {
    return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

const sumThree2 = curriedSum(3);
console.log(sumThree2(4)(20)(6)); // => 30

const sumFour = curriedSum(4);
console.log(sumFour(5)(30)(20)(1)); // => 56