// let foo = []
// for (var i = 0; i < 10; i++) {
//     foo[i] = function() { return i }
// }

// console.log(foo[0]())
// console.log(foo[1]())
// console.log(foo[2]())

const example = [1,2,3,4,5]

// Array#myEach(callback)
Array.prototype.myEach = function(callback){
    for(let i = 0; i < this.length; i++){
        callback(this[i]);
    }
}

example.myEach((el) => {
    console.log(`${el * 2}`);
});
// 2
// 4
// 6
// 8
// 10

// Array#myMap)(callback)
Array.prototype.myMap = function(callback){
    const newArray = [];
    this.myEach((el) => newArray.push(callback(el)))
    return newArray;
}

console.log(example.myMap((el)=> el * 2));
// [2, 4, 6, 8, 10]

// Array#myReduce(callback[, initialValue])
Array.prototype.myReduce = function(callback, initialValue){
    let copy = this
    let result = 0;
    // if no initialValue, first value is first index
    if (initialValue === undefined){
        initialValue = copy[0];
        copy = copy.slice(1);
    }
    result += initialValue;
    // if there is initalValue, copy stays as this
    copy.myEach((el) => result = callback(result, el))
    return result;
}

function square(el){
    return el ** 2;
}

// without initialValue
[1, 2, 3].myReduce(function (acc, el) {
    return acc + el;
}); // => 6

// with initialValue
[1, 2, 3].myReduce(function (acc, el) {
    return acc + el;
}, 25); // => 31

console.log(example.myReduce((total, el) => total + el ** 2));
// 55 => 1 + 2**2 + 3**2 + 4**2 + 5**2
console.log(example.myReduce((total, el) => total + el ** 2, 100));
// 155
console.log(example.myReduce((total, item) => total + item));
// 15 => 1 + 2 + 3 + 4 + 5