// my_min
// Given a list of integers find the smallest number in the list.

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
console.log(my_min(list))  // # =>  -5

// Phase I
// First, write a function that compares each element to every other element of the list. 
// Return the element if all other elements in the array are larger.

// What is the time complexity for this function?
function my_min_1(arr) {
  let min = arr[0];
  for (let i = 0; i < arr.length - 1; i++) {
    for (let j = i + 1; j < arr.length; j++) {
      if (arr[i] < arr[j] && arr[i] <= min) {
        min = arr[i]
      }
    }
  }
  return min;
}

// Time Complexity: O(n^2)
// Space Complexity: O(n^2)

// Phase II
// Now ,rewrite the function to iterate through the list just once while keeping track of the minimum.

// What is the time complexity?
function my_min(arr) {
  let min = arr[0];
  arr.forEach(n => { 
    if (n < min) {
      min = n;
    }
  })
  return min;
}
// Time Complexity: O(n)
// Space Complexity: O(1)