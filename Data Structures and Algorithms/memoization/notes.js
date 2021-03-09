// The underlying idea of memoization is this: every time we call a function with a particular argument, 
// we expect to get the same result every time. 
// Memoization allows us to store the result of a function in an object so it can be recalled later on. 
// There are two features that comprise Memoization:
  // the function is recursive
  // the additional data structure used is typically an object (we refer to this as the memo!)

// Memoization is useful when attacking recursive problems that have many overlapping subproblems. 
// You'll find it most useful to draw out the visual tree first. 
// If you notice duplicate subtrees, time to memoize.

// Factorial
let memo = {};

function memo_factorial(n) {
  // if we have calculated n previously, fetch stored result in O(1) time
  if (n in memo) return memo[n]
  if (n === 1) return n;
  // else calculate factorial and save to memo
  memo[n] = n * memo_factorial(n - 1);
  // return result
  return memo[n];
}

console.log(memo_factorial(6)) // calls 6 times
console.log(memo_factorial(6)) // calls 1 time
console.log(memo_factorial(5)) // calls 1 time

// we have result for all args 2 to 7
console.log(memo) // { '2': 2, '3': 6, '4': 24, '5': 120, '6': 720 }

// Fibonacci
// default object arg
function memo_fib(n, memo = {}) {
  if (n in memo) return memo[n];
  if (n === 1 || n === 2) return 1;
  memo[n] = memo_fib(n - 1, memo) + memo_fib(n - 2, memo);
  return memo[n];
}
// store subtrees in memo, like f(5) = f(4) + f(3), f(4) = f(3) + f(1), f(3) is a subtree that overlaps
// then only need to explore a subtree fully once

// O(2^n) to O(n) => we explore the tree only branches on one side and store others in memo

console.log(memo_fib(5)); // memo => { '3': 2, '4': 3, '5': 5 }
console.log(memo_fib(50))
// memo = {
//   '3': 2,
//   '4': 3,
//   '5': 5,
//   ...
//   '48': 4807526976,
//   '49': 7778742049,
//   '50': 12586269025
// }