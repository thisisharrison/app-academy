// find_missing_number
// Assume an array of non-negative integers. 
// A second array is formed by shuffling the elements of the first array and deleting a random element. 
// Given these two arrays, find which element is missing in the second array. 
// Do this in linear time with constant memory use.

// Method Signature
// find_missing_number(array arr1, array arr2)

function find_missing_number(arr1, arr2) {
  // sum of arr1 - sum of arr2 = missing number
  const sum1 = arr1.reduce((a, b) => a + b, 0);
  const sum2 = arr2.reduce((a, b) => a + b, 0);

  return sum1 - sum2
}

// Example input/output
console.log(find_missing_number([8,3,5,1], [1,5,3])) // = 8
console.log(find_missing_number([1,1,1,1], [1,1,1])) // = 1
console.log(find_missing_number([3,5,4,8,7,9], [7,4,3,5,9])) // = 8

// Time Complexity: O(n)
// Space Complexity: O(1)