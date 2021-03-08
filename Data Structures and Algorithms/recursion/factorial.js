function factorial(num) {
  // base cases
  if (num === 0) return 1;
  if (num === 1) return num;
  // recursive step: makes progress towards base case
  return num * factorial(num - 1);
}

console.log(factorial(5)) // => 120

// O(n)