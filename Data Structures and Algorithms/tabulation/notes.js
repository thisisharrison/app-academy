/*
There are two main features that comprise the Tabulation strategy:
  the function is iterative and not recursive
  the additional data structure used is typically an array (we refer to this as the table!)

Tabulation is all about creating a table (array) and filling it out with elements. 
In general, we will complete the table by filling entries from left to right. 
This means that the first entry of our table (first element of the array) will 
correspond to the smallest subproblem. 
Naturally, the final entry of our table (last element of the array) will 
correspond to the largest problem, which is also our final answer.

This is just a general recipe so adjust for taste depending on your problem:
  Create the table array based off of the size of the input
    this isn't always straightforward if you have multiple args
  Initialize some values in the table that "answer" the trivially small subproblem
    usually this means initializing the first entry of the table
  Iterate through the array and fill in remaining entries
    calculating the next entry should require using other entries of the table
  Your final answer is the last entry in the table (usually)
*/

function tabulate_fib(n) {
  // create table, length of n + 1 so we can find fib just by indexing n 
  let tab = new Array(n + 1);
  // seed "base case"
  tab[0] = 0;
  tab[1] = 1;
  // complete table
  for (let i = 2; i <= n + 1; i++) {
    tab[i] = tab[i - 1] + tab[i - 2]
  }
  return tab[n];
}

// Time: O(n)
// Space: O(n)

console.log(tabulate_fib(7))
// [ 1, 2, 3, 5, 8, 13 ]
// 13

function tabulate_fib_constant_space(n) {
  if (n === 0) return 0;
  if (n === 1) return 1;

  // the first fib number
  let secondLast = 0;
  // the second fib number
  let last = 1;
  for (let i = 2; i <= n; i++) {
    // O(1) space, holding last as a temp variable
    let temp = last;
    // update last to be n-1 + n-2 <=> last + secondLast
    last = last + secondLast;
    // update secondlast to previous last
    secondLast = temp;
  }

  return last;
}

// Space O(1)
console.log(tabulate_fib_constant_space(7))