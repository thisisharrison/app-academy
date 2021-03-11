// Given a string s and a dictionary of strings wordDict, return true if s can be segmented into 
// a space-separated sequence of one or more dictionary words.

// Note that the same word in the dictionary may be reused multiple times in the segmentation.

// Input: s = "leetcode", wordDict = ["leet","code"]
// Output: true
// Explanation: Return true because "leetcode" can be segmented as "leet code".

// Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
// Output: false


var wordBreak = function(s, wordDict) {
    // initialize array, filled with falses
    let table = new Array(s.length + 1).fill(false);
    // "base case" and should return true if empty string
    table[0] = true;
    for (let i = 0; i < table.length; i++) {
        // if false, continue
        if (!table[i]) continue;
        for (let j = i + 1; j < table.length; j++) {
            // evaluate string starting from an index of true
            let word = s.slice(i, j);
            if (wordDict.includes(word)) {
                table[j] = true
            }
        }
    }
    return table[table.length - 1];
};