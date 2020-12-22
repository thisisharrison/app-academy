// Array#uniq
// returns a new array containing each individual element of the original array only once(creating all unique elements)
// the elements should be in the order in which they first appear in the original array
// should not mutate the original array

// Array#twoSum
// returns an array of position pairs where the elements sum to zero

// Array#transpose
// where we have a two - dimensional array representing a matrix.returns the transpose

Array.prototype.uniq = function(){
    let hash = {};
    this.forEach(el => hash[el] = true);
    return Object.keys(hash);
}

Array.prototype.uniq2 = function () {
    let unique = [];
    this.forEach(el => {
        // -1 means not found
        if (unique.indexOf(el) === -1) {
            unique.push(el);
        }
    });
    return unique;
}

[1, 2, 2, 3, 3, 3].uniq();
// [1, 2, 3])

// O(n^2) 
Array.prototype.twoSum = function (){
    // create a hash
    let hash = {}
    // key is sum and value is index of two els
    for(let i = 0; i < this.length; i++){
        for(let j = (i + 1); j < this.length; j++){
            let sum = this[i] + this[j];
            if (hash[sum]) {
                hash[sum].push([i, j]);
            } else {
                hash[sum] = [[i, j]];
            }
            
        }
    }
    return hash[0];
}

// O(n)
Array.prototype.twoSum2 = function () {
    let result = [];
    // key num, value index 
    const indexHash = {};

    // loop each num
    this.forEach((num, idx) => {
        // look for the negative
        if (indexHash[num * -1]) {
            // Add this index to all other indices with this key
            // [1,2,3].map((num)=>[num, 4]) -> [1,4], [2,4], [3,4]
            const newPair = indexHash[num * -1].map((prevIndices) => [prevIndixes, idx]);
            // add the pairs to result
            result = result.concat(newPair);
        }

        // look for the positive
        indexHash[el] ? indexHash[el].push(idx) : indexHash[el] = [idx];
    })
    return result;
}

[-1, -1, 3, 5, 6, 1, -5].twoSum();
// [ [ 0, 5 ], [ 1, 5 ], [ 3, 6 ] ]


Array.prototype.transpose = function () {
    // Array.from default lenght is 1, setting it to original sub array count
    // Array.from takes a map function, setting subarray to be length of sub array length
    let result = Array.from({ length: this.length }, () => Array.from({ length: this[0].length }));
    
    for(let i = 0; i < this.length; i++){
        for(let j = 0; j < this[i].length; j++){
            result[j][i] = this[i][j]
        }
    }
    return result
}

[[1,2],[3,4]].transpose();
// [[1,3],[2,4]]
[[1,2,3],[4,5,6],[7,8,9]].transpose()
// [[1, 4, 7], [2, 5, 8], [3, 6, 9]]

