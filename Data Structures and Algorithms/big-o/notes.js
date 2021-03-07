// Constant O(1)
function constant_1(n) {
  return n * 2 + 1
}
// T(2) => O(1)

function constant_2(n) {
  for (let i = 0; i <= 100; i++) {
    // do something and doesn't depend on n
  }
}
// T(100) => O(1)
// no relationship between the size of the input and the number of steps required

// Logarithmic O(log(n))
function logarithmic(n) {
  if (n <= 1) return ;
  logarithmic(n / 2);
}
// time execution is proportional to the log of the input size
// recursion: halving input each call
// eg. 8 => 4 => 2 => 1
// 2^3 = 8, log(8) = 3 => O(log(n))
// we don't have to touch every element of the input (discarding chunks of the input)
// everytime we double our input, we increase 1 step

// Linear O(n)
// iterative
function linear(n) {
  for (let i = 0; i <= n; i++) {
    // do something n times
  }
}
// O(n)

// recursive
function linear_2(n) {
  if (n === 1) return;
  linear_2(n - 1)
}
// n = 10, then 9, 8, ... 1
// T(10) = O(n)
// touch every element or reduce by one each recursive call

// log linear O(n*log(n))
function loglinear(n) {
  if (n === 1) return;
  for (let i = 0; i <= n; i++) {
    // do something n times
  }
  loglinear(n / 2); // halving the input
  loglinear(n / 2); // halving the input
}
// eg. n = 8
// each recursive call does something 8 times O(n)
// total recursive call = 3, log(8) = 3
// halving inputs each time but iteration is also performed

function logliner_2(str) {
  if (str.length === 1) return;
  let midIdx = Math.floor(str.length / 2)
  let left = str.slice(0, midIdx)
  let right = str.slice(midIdx)
  logliner_2(left)
  logliner_2(right)
}
// left and right combined will be n times of operation
// total recursive call will be log(n) as we're halving the input

// polynomial O(n^2)
function quadratic(n) {
  for (let i = 0; i <= n; i++) {
    for (let j = 1; j <= n; j++) {
      // do something
    }
  }
}
// grows directly proportional to the square of the size of the input

// exponential O(2^n)
// growth rate doubles with each addition to input n
function exponential_2n(n) {
  if (n === 1) return;
  exponential_2n(n - 1)
  exponential_2n(n - 1)
}
// every call leads to two more recursive calls
// base is number of recursive calls (2 in above example)
// we go as deep as our input n
// eg. n = 4
//        4
//    3       3
//  2   2   2   2
// 1 1|1 1|1 1|1 1
// we always branch constant C times (C = 2 in this case)
// not the case in factorial

function exponential_4n(n) {
  if (n === 1) return;
  for (let i = 1; i <= 4; i++) {
    exponential_4n(n - 1)
  }
}
// number of recursive call 4
// O(4^n)

// factorial O(n!)
function factorial(n) {
  if (n === 1) return;
  for (let i = 1; i <= n; i++) {
    factorial(n - 1)
  }
}
// number of recursive call here depends on input n, so it is not contant
// recursive code that has a variable number of recursive calls in each stack frame
// every branch depends on n 
// eg. n = 4
//            4
//   3     3     3     3
// 2 2 2|2 2 2|2 2 2|2 2 2