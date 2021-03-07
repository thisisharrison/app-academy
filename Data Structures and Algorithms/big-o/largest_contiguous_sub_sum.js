// Largest Contiguous Sub-sum
// You have an array of integers and you want to find the largest contiguous (together in sequence) sub-sum. 
// Find the sums of all contiguous sub-arrays and return the max.

// Example:
list = [5, 3, -7]
console.log(largest_contiguous_subsum(list)) //# => 8

//     # possible sub-sums
//     [5]           # => 5
//     [5, 3]        # => 8 --> we want this one
//     [5, 3, -7]    # => 1
//     [3]           # => 3
//     [3, -7]       # => -4
//     [-7]          # => -7

// Example 2:

list = [2, 3, -6, 7, -6, 7]
console.log(largest_contiguous_subsum(list)) //# => 8 (from [7, -6, 7])

// Example 3:

list = [-5, -1, -3]
console.log(largest_contiguous_subsum(list)) //# => -1 (from [-1])

// Phase I
// Write a function that iterates through the array and finds all sub-arrays using nested loops. 
// First make an array to hold all sub-arrays. Then find the sums of each sub-array and return the max.

// Discuss the time complexity of this solution.
function largest_contiguous_subsum_slow(list) {
  let allSub = [];
  for (let i = 0; i < list.length; i++) {
    for (let j = i + 1; j <= list.length; j++) {
      allSub.push(list.slice(i, j))
    }
  }
  return allSub.map(sub => sub.reduce((cur, acc) => acc += cur,0))
    .sort((a, b) => b - a)[0]
}

// Time Complexity: O(n^3)
  // 2 for loops and 1 map
// Space Complexity: O(n^3)

// Phase II
// Let's make a better version. Write a new function using O(n) time with O(1) memory. Keep a running tally of the largest sum.
function largest_contiguous_subsum(list) {
  let max = list[0];
  let curr = list[0];

  // if all are negative, return largest negative
  if (list.every(num => num < 0)) return Math.max.apply(null, list);

  for (let i = 1; i < list.length; i++) {
    // reset the subset
    if (curr < 0) curr = 0;
    curr += list[i];
    if (max < curr) {
      max = curr
    }
  }
  return max;
}

// Time Complexity: T(2n) => O(n)
// Space Complexity: T(2) => O(1)