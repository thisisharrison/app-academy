const harry = { name: "harry" }

// BIND
function bind_greet(){
 console.log(`${this.name} says hi`)
}
// BIND needs () as it creates a copy of the function with this set to harry
// Then we still need to invoke it
// CALL and APPLY does not require () at the end
bind_greet.bind(harry)()
// harry says hi




// APPLY
function apply_greet(msg){
 console.log(`${this.name} says ${msg}`)
}
apply_greet.bind(harry, 'hi')()
// harry says hi
apply_greet.apply(harry,['hi'])
// harry says hi




// CALL
function call_greet(msg1, msg2){
 console.log(`${this.name} says ${msg1} and ${msg2}`)
}
call_greet.bind(harry, 'hi')()
// harry says hi and undefined
call_greet.bind(harry, 'hi', 'bye')()
// harry says hi and bye
call_greet.apply(harry, 'hi')
// TypeError: CreateListFromArrayLike called on non - object
call_greet.call(harry, 'hi','bye')
// harry says hi and bye
call_greet.call(harry, 'hi')
// harry says hi and undefined




// FUNCTION CURRYING (BIND)
// Creating copy of function with preset param
function multiply (a, b) {
    return a * b;
}

// Hard coding this to be 'a'
// Bind creating 'copy' of multiply function
const multiplyByTwo = multiply.bind(this, 2)
// Equivalent to:
// function multiplyByTwo (b) {
//     const a = 2;
//     return a * b;
// }

multiplyByTwo(4);
// 8