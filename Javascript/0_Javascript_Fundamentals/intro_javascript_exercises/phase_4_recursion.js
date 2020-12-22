// range(start, end)
// receives a start and end value, returns an array from start up to end

function range(start, end){
    if (start === end) { return [] }
    let result = range(start, end - 1);
    result.push(end - 1);
    return result;
}
range(0,5);
// [0, 1, 2, 3, 4]

// sumRec(arr)
// receives an array of numbers and recursively sums them

function sumRec(arr){
    if (arr.length === 1) { return arr[0] }
    let sum = arr[0] + sumRec(arr.slice(1));
    return sum;
}

function iterSum(arr) {
    let total = 0;
    arr.forEach((el) => total += el);
    return total;
}
// Reduce (Ruby ~ Array#Inject)
function iterSum2(arr) {
    let total = arr.reduce((total, el) => total + el);
    return total;
}

sumRec([1, 2, 3, 4, 5]);
// 15
iterSum([1, 2, 3, 4, 5]);
// 15
iterSum2([1, 2, 3, 4, 5]);
// 15

// exponent(base, exp) 
// receives a base and exponent, returns the base raise to the power of the exponent(base ^ exp)

// # version 1
// exp(b, 0) = 1
// exp(b, n) = b * exp(b, n - 1)

function exponent1(base, exp){
    // One liner: 
    return exp === 0 ? 1 : base * exponent1(base, exp - 1);
    // Original: 
    // if (exp === 0) { return 1 }
    // let result = base * exponent1(base, exp - 1);
    // return result;
}
exponent1(2, 2);
// 4
exponent1(3, 2);
// 9


// # recursion 2
// exp(b, 0) = 1
// exp(b, 1) = b
// exp(b, n) = exp(b, n / 2) ** 2[for even n]
// exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2)[for odd n]
function exponent2(base, exp){
    if (exp === 0) { return 1 }
    if (exp % 2 === 0) {
        let partial = exponent2(base, exp / 2);
        return partial * partial;
    } else {
        let partial = base * exponent2(base, (exp - 1) / 2);
        return base * partial * partial;
    }
}
exponent2(2, 2);
// 64
exponent2(3, 2);
// 729

// fibonacci(n) 
// receives an integer, n, and returns the first n Fibonacci numbers
function fibonacci(n){
    // One liner for base case: Slice start idx to end idx
    if (n < 3) { return [0, 1].slice(0, n) }
    // Original:
    // if (n < 1) { return [] }
    // if (n === 1) { return [0] }
    // if (n === 2) { return [0, 1]}

    let result = fibonacci(n - 1);
    result.push( result[result.length - 1] + result[result.length - 2] );
    return result;
}

function iterFib(n){
    let result = [0, 1];
    if (n < 3) { return [0, 1].slice(0, n) }
    
    while (result.length < n) {
        result.push(result[result.length - 1] + result[result.length - 2]);
    } 
    return result;
}

fibonacci(0);
// []
fibonacci(1);
// [0]
fibonacci(2);
// [0, 1]
fibonacci(9);
// [0, 1, 1, 2, 3, 5, 8, 13, 21]
iterFib(0);
// []
iterFib(1);
// [0]
iterFib(2);
// [0, 1]
iterFib(9);
// [0, 1, 1, 2, 3, 5, 8, 13, 21]

// deepDup(arr) 
// deep dup of an Array!
function deepDup(arr){
    if (!(arr instanceof Array)) { return arr; }
    return arr.map((el) => {
        return deepDup(el);
    })
}
const array = [[2], 3, [4, 5]];
const dupedArray = deepDup(array);
console.log(`deepDup original = ${JSON.stringify(array)}`);
// deepDup original = [[2], 3, [4, 5]]

dupedArray[0].push(4);

console.log(`deepDup original = ${JSON.stringify(array)} (should not be mutated)`);
// deepDup original = [[2],3,[4,5]] (should not be mutated)

console.log(`deepDup duped = ${JSON.stringify(dupedArray)} (should be mutated)`);
// deepDup duped = [[2, 4], 3, [4, 5]](should be mutated)

// bsearch(arr, target) 
// receives a sorted array, returns the index of the target or - 1 if not found

function bsearch(arr, target){
    if (arr.length === 0) { 
        return -1; 
    } else if (arr.length === 1 && arr[0] != target) {
        return -1;
    }
    let halfIdx = Math.floor(arr.length / 2)
    if (arr[halfIdx] === target) { 
        return halfIdx; 
    } else if (arr[halfIdx] > target) {
        return searchLeft = bsearch(arr.slice(0, halfIdx), target);
    } else {
        return searchRight = bsearch(arr.slice(halfIdx, arr.length), target);
    }
}
bsearch([1, 2, 3, 4, 5, 6], 2);
bsearch([1, 2, 3, 4, 5, 6], 4);
bsearch([1, 2, 3, 4, 5, 6], 100);
bsearch([1, 2, 3, 4, 5, 6], 0);

// mergesort(arr) 
// receives an array, returns a sorted copy of the array by implementing merge sort sorting algorithm

function mergesort(arr){
    if (arr.length < 2) { return arr; }
    let halfIdx = Math.floor(arr.length / 2);

    const left = mergesort(arr.slice(0, halfIdx));
    const right = mergesort(arr.slice(halfIdx));

    return merge(left, right);
}
function merge(left, right){
    const merged = [];
    while (left.length > 0 && right.length > 0){
        let nextItem = (left[0] > right[0]) ? right.shift() : left.shift();
        merged.push(nextItem);
    }
    // concat (push) the left overs
    return merged.concat(left, right);
}
mergesort([5, 4, 3, 2, 1])
// [ 1, 2, 3, 4, 5 ]

// subsets(arr) 
// receives an array, returns an array containing all the subsets of the original array
function subsets(arr){
    if (arr.length === 0) { return [[]]; }
    let first = [arr[0]]
    const withoutFirst = subsets(arr.slice(1));
    const withFirst = withoutFirst.map(el => first.concat(el) )
    return withoutFirst.concat(withFirst);
}
subsets([1, 3, 5]);
// [5, [3, 5], [1, 5], [1, 3, 5]]