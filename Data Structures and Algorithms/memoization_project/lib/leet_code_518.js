// Work through this problem on https://leetcode.com/problems/coin-change-2/ and use the specs given there.
// Feel free to use this file for scratch work.

// You are given coins of different denominations and a total amount of money. 
// Write a function to compute the number of combinations that make up that amount. 
// You may assume that you have infinite number of each kind of coin.

// Example 1:
// Input: amount = 5, coins = [1, 2, 5]
// Output: 4
// Explanation: there are four ways to make up the amount:
// 5=5
// 5=2+2+1
// 5=2+1+1+1
// 5=1+1+1+1+1

// Example 2:
// Input: amount = 3, coins = [2]
// Output: 0
// Explanation: the amount of 3 cannot be made up just with coins of 2.

// Example 3:
// Input: amount = 10, coins = [10] 
// Output: 1


// build tree, each level explore quantities of coin
// if path returns 1, there's 1 way to make change, if 0, there's 0 way
function change(amount, coins) {
  // if amount = 0, then there's 1 way to give them back their change
  if (amount === 0) return 1;

  // take a coin and see if we get an amount
  let currCoin = coins[coins.length - 1]
  let numWays = 0

  for (let qty = 0; qty * currCoin < amount; qty++) {
    // accumulate the ways to make change
    numWays += change(amount - qty * currCoin, coins.slice(0, -1))
  }
  
  return numWays;
}

function memo_change(amount, coins, memo={}) {
  // create key that includes data on amount and varied coins array
  let key = amount + '-' + coins;
  if (key in memo) return memo[key];
  if (amount === 0) return 1;

  let currCoin = coins[coins.length - 1]
  let numWays = 0

  for (let qty = 0; qty * currCoin <= amount; qty++) {
    numWays += change(amount - qty * currCoin, coins.slice(0, -1), memo)
  }
  
  memo[key] = numWays;
  return memo[key];
}
