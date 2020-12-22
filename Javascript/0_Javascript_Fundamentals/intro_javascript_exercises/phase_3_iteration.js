// Array#bubbleSort
Array.prototype.mySort = function(){
    let unsorted = true
    while (unsorted){
        unsorted = false
        for(let i = 0; i < this.length - 1; i++){
            switch(this[i] <= this[i+1]){
                case true:
                    break;
                case false: 
                    // let switchVar = this[i]
                    // this[i] = this[i + 1];
                    // this[i + 1] = switchVar;
                    [this[i], this[i + 1]] = [this[i + 1], this[i]];
                    unsorted = true;
                    break;
            }   
        }
    }
    return this;
}
[8, 10, 2, 9, 3, 4, 5, 7, 6].mySort();
// [ 2, 3, 4, 5, 6, 7, 8, 9, 10 ]

// String#substrings
String.prototype.substrings = function(){
    let substrings = [];
    for(let start = 0; start < this.length; start++){
        for(let end = start + 1; end <= this.length; end++){
            substrings.push(this.slice(start,end));
        }
    }
    return substrings;
}
"abc".substrings();
// ['a', 'ab', 'abc', 'b', 'bc', 'c']