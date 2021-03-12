// Write a function, stepper(nums), that takes in an array of non negative numbers.
// Each element of the array represents the maximum number of steps you can take from that position in the array.
// The function should return a boolean indicating if it is possible to travel from the 
// first position of the array to the last position.
//
// For Example:
//
// Given [3, 1, 0, 5, 10]
//      - We begin at first position, 3. 
//      - Since the element is 3 we can take up to 3 steps from this position.
//      - This means we can step to the 1, 0, or 5
//      - Say we step to 1
//      - Since the element is 1, now the only option is to take 1 step to land on 0
//      - etc...
//
// Try to solve this in two ways, using tabulation and memoization.
//
// Examples:
//
// stepper([3, 1, 0, 5, 10]);           // => true, because we can step through elements 3 -> 5 -> 10
// stepper([3, 4, 1, 0, 10]);           // => true, because we can step through elements 3 -> 4 -> 10
// stepper([2, 3, 1, 1, 0, 4, 7, 8])    // => false, there is no way to step to the end

// with tabulation
// function stepper(nums) {
//   // explore each index and see if we reach the end
//   // initialize nums with false
//   let table = new Array(nums.length).fill(false);
//   // we can always get to the first step so set 0 to true
//   table[0] = true;
//   // step through the array
//   for (let i = 0; i < nums.length; i++) {
//     // only operate if this is true, which starting point 0 is 
//     if (table[i] === true) {
//       // get the steps from input array
//       let maxSteps = nums[i];
//       // we take at most 1 step and maximum inclusive max steps eg. 3 -> 5
//       for (let j = 1; j <= maxSteps; j++) {
//         // set where we landed to true
//         table[i + j] = true;
//       }
//     }
//   }
//   // do we have true in the last num
//   return table[nums.length - 1];
// }

// with memo
function stepper(nums, memo = {}) {
  // key can be length of the array, that is always unique
  let key = nums.length;
  if (key in memo) return memo[key];
  // base case, no steps needed and at the end of nums
  if (nums.length === 0) return true;
  // the current call's max step
  let maxStep = nums[0];
  // iterate and recursive call per step
  for (let step = 1; step <= maxStep; step++) {
    // call stepper with smaller and smaller array
    if (stepper(nums.slice(step), memo)) {
      memo[key] = true;
      return true;
    }
  }
  // none of the children calls return true
  memo[key] = false;
  return false;
}


// Write a function, maxNonAdjacentSum(nums), that takes in an array of nonnegative numbers.
// The function should return the maximum sum of elements in the array we can get if we cannot take
// adjacent elements into the sum.
//
// Try to solve this in two ways, using tabulation and memoization.
//
// Examples:
//
// maxNonAdjacentSum([2, 7, 9, 3, 4])   // => 15, because 2 + 9 + 4
// maxNonAdjacentSum([4,2,1,6])         // => 10, because 4 + 6 

// with tabulation
// function maxNonAdjacentSum(nums) {
//   // edge case
//   if (nums.length === 0) return 0;
  
//   // the return value is sum, so initialize with 0
//   // table will store sums
//   let table = new Array (nums.length).fill(0);
  
//   // minimum sum would be the 0 index number
//   table[0] = nums[0];

//   // i is max adjacent sum from 1 up to i, 0 is already nums[0]
//   for (let i = 1; i < nums.length; i++) {
//     // you can get the sum of i -2 but not i - 1
//     let leftLeft = table[i - 2] === undefined ? 0 : table[i - 2];
//     // the adjacent sum if including current num
//     let includeThisNum = nums[i] + leftLeft;
//     // previous maxsum
//     let notIncludeThisNum = table[i - 1];
//     table[i] = Math.max(includeThisNum, notIncludeThisNum);
//   }
  
//   // the max sum
//   return table[nums.length - 1]
// }

// with memo
function maxNonAdjacentSum(nums, memo = {}) {
  // base cases
  // already cached
  if (nums.length in memo) return memo[nums.length];
  // length of 0, sum of nothing
  if (nums.length === 0) return 0;

  let first = nums[0];

  // include this num and add non adjacent (slice 2)
  // or not include this num and call again starting with adjacent num
  memo[nums.length] = Math.max(
    first + maxNonAdjacentSum(nums.slice(2), memo), 
    maxNonAdjacentSum(nums.slice(1), memo)
    );
  
  return memo[nums.length];
}

// Write a function, minChange(coins, amount), that accepts an array of coin values
// and a target amount as arguments. The method should the minimum number of coins needed
// to make the target amount. A coin value can be used multiple times.
//
// You've seen this problem before with memoization, but now solve it using the Tabulation strategy!
//
// Examples:
//
// minChange([1, 2, 5], 11)         // => 3, because 5 + 5 + 1 = 11
// minChange([1, 4, 5], 8))         // => 2, because 4 + 4 = 8
// minChange([1, 5, 10, 25], 15)    // => 2, because 10 + 5 = 15
// minChange([1, 5, 10, 25], 100)   // => 4, because 25 + 25 + 25 + 25 = 100
function minChange(coins, amount) {
  // + 1 to align indices and so we can do table[amount]
  let table = new Array(amount + 1).fill(Infinity);
  // also if amount is 0, we should give back 0 change
  table[0] = 0;
  // loop through coins
  coins.forEach(coin => {
    // loop through table (amounts)
    for (let amt = 0; amt < table.length; amt++) {
      // loop through qty of coins
      for (let qty = 0; qty * coin <= amt; qty++) {
        let remainder = amt - qty * coin;
        let attempt = table[remainder] + qty;
        if (attempt < table[amt]) table[amt] = attempt;
      }
    }
  })
  return table[amount]
}


module.exports = {
    stepper,
    maxNonAdjacentSum,
    minChange
};