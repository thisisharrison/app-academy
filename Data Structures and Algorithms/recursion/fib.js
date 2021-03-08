// Write a method fib(n) that takes in a number and returns the nth number of
// the fibonacci sequence.
//
// In the fibonacci sequence, the 1st number is 1 and the 2nd number is 1. To generate the
// next number in the sequence, we take the sum of the previous two fibonacci numbers.
// For example the first 5 numbers of the fibonacci sequence are `1, 1, 2, 3, 5`
//
// Examples:
//
// fib(1) // => 1 = base case
// fib(2) // => 1 = base case
// fib(3) // => 2 = fib(2) + fib(1)
// fib(4) // => 3 = fib(3) + fib(2)
// fib(5) // => 5 = fib(4) + fib(3) = fib(n-1) + fib(n-2)
// fib(6) // => 8
// fib(7) // => 13

function fib(n) {
  if (n == 1 || n == 2) return 1;
  return fib(n - 1) + fib(n - 2);
}

// each call branches twice, leads to two more calls
// T(n) = 2^(n-1) + 2^(n - 2)
// O(n) = 2^n

console.log(fib(1))
console.log(fib(2))
console.log(fib(3))
console.log(fib(4))
console.log(fib(5))
console.log(fib(6))
console.log(fib(7))