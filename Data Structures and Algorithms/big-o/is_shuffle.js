// is_shuffle?
// Given three strings, return whether the third is an interleaving of the first two. 
// Interleaving means it only contains characters from the other two, no more no less, 
// and preserves their character ordering. "abdecf" is an interleaving of "abc" and "def".

console.log(is_shuffle('XXZ', 'XXY', 'XXYXXZ'))
// => true

console.log(is_shuffle("abc", "def", "abdecf"))
// => true

function is_shuffle_log(s1, s2, s3) {
  return (s1 + s2).split("").sort().join("") === s3.split("").sort().join("")
}

// sort time complexity: O(nlog(n))

// non-repeating
// works for 2nd case but not 1st
// s1[2] !== s3[2] (X and Y)
// then it'll compare s2[0] and s3[2], X and Y
// so it'll hit false and return
function is_shuffle_non_repeat(s1, s2, s3) {
  if (s1.length + s2.length !== s3.length) {
    return false;
  }
  let i1 = 0;
  let i2 = 0;
  let i3 = 0;

  while(i3 < s3.length) {
    if (s1[i1] === s3[i3]) {
      i1 += 1;
      i3 += 1;
    } else if (s2[i2] === s3[i3]) {
      i2 += 1;
      i3 += 1;
    } else {
      return false;
    }
  }
  return true;
}

// repeating
// use recursion
// s1 goes and find interleave string
// s2 goes and find interleave string
function is_shuffle_2_n(s1, s2, s3) {
  if (s3.length === 0) {
    return s1.length === 0 && s2.length === 0;
  }
  if (s1[0] === s3[0]) {
    if (is_shuffle(s1.slice(1, s1.length), s2, s3.slice(1, s3.length))) {
      return true;
    }
  }
  if (s2[0] === s3[0]) {
    if (is_shuffle(s1, s2.slice(1, s2.length), s3.slice(1, s3.length))) {
      return true;
    }
  }
  return false;
}
// O(2^n)
