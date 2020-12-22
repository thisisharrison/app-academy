// PHASE: 1

function mysteryScoping1() {
    var x = 'out of block';
    if (true) {
        var x = 'in block';
        console.log(x);
    }
    console.log(x);
}
// mysteryScoping1()
// in block
// in block

function mysteryScoping2() {
    const x = 'out of block';
    if (true) {
        const x = 'in block';
        console.log(x);
    }
    console.log(x);
}
// mysteryScoping2()
// in block
// out of block

function mysteryScoping3() {
    const x = 'out of block';
    if (true) {
        var x = 'in block';
        console.log(x);
    }
    console.log(x);
}
// mysteryScoping3()
// error: can't redfine const x 

function mysteryScoping4() {
    let x = 'out of block';
    if (true) {
        let x = 'in block';
        console.log(x);
    }
    console.log(x);
}
// mysteryScoping4()
// in block
// out block

function mysteryScoping5() {
    let x = 'out of block';
    if (true) {
        let x = 'in block';
        console.log(x);
    }
    let x = 'out of block again';
    console.log(x);
}
// mysteryScoping5()
// out of block again cannot be defined x has been declared

function madLib(verb, adj, noun) {
    console.log(`We shall ${verb.toUpperCase()} the ${adj.toUpperCase()} ${noun.toUpperCase()}`);
}
// madLib("make", "best", "taco")

function isSubstring(searchString, subString) {
    return searchString.includes(subString);
}
// console.log(isSubstring("time to program", "time"))
// true
// console.log(isSubstring("Jump for joy", "joys"))
// false

// PHASE 2:
function fizzBuzz(array) {
    function isDivisible(num) {
        // xor returns 0 if both true. 0 is falsey
        if (num % 3 === 0 ^ num % 5 === 0) {
            return num;
        }
    }
    return array.filter(isDivisible);
}
// console.log(fizzBuzz([3, 6, 9, 15, 16, 17, 20]))

function fizzBuzz2(array) {
    let result = []
    array.forEach(num => {
        if (num % 3 === 0 ^ num % 5 === 0) {
            result.push(num);
        }
    })
    return result;
}
// console.log(fizzBuzz2([3, 6, 9, 15, 16, 17, 20]))

function isPrime(num) {
    if (num < 2) { return false }
    for (let i = 2; num > i; i++) {
        if (num % i === 0) {
            return false;
        }
    }
    return true;
}
// console.log(isPrime(2))
// true
// console.log(isPrime(10))
// false
// console.log(isPrime(15485863))
// true
// console.log(isPrime(3548563))
// false

function sumOfNPrimes(n) {
    let i = 2
    let count = 0
    let result = 0
    while (count < n) {
        if (isPrime(i)) {
            count++;
            result += i
        }
        i++;
    }
    return result;
}

// console.log(sumOfNPrimes(0))
//0
// console.log(sumOfNPrimes(1))
//2
// console.log(sumOfNPrimes(4))
//17