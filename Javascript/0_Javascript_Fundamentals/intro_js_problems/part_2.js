// PHASE 1: Callbacks
function titleize(array, callback) {
    let new_arr = array.map(name => {return `Mx.${name} Jingleheimer Schmidt`});
    callback(new_arr);
}

titleize(["Mary", "Brian", "Leo"], (new_arr) => {
     new_arr.forEach(name => console.log(name));
});
// Mx.Mary Jingleheimer Schmidt
// Mx.Brian Jingleheimer Schmidt
// Mx.Leo Jingleheimer Schmidt

// PHASE 2: Constructors, Prototypes, and this
function Elephant(name, height, tricks) {
    this.name = name;
    this.height = height;
    this.tricks = tricks;
}
const Dumbo = new Elephant("Dumbo", 1000, ["flying", "painting a picture"])

Elephant.prototype.trumpet = function(){
    console.log(`${this.name} goes 'phrRRRRRRRRRRR!!!!!!!'`);
}

Dumbo.trumpet();

Elephant.prototype.grow = function(){
    this.height += 12;
}

Dumbo.grow();
console.log(Dumbo.height)

Elephant.prototype.addTrick = function(trick){
    this.tricks.push(trick);
}

Dumbo.addTrick("singing");
console.log(Dumbo.tricks)

Elephant.prototype.play = function(){
    function getIndex(min, max){
        return Math.floor(Math.random() * (max - min) + min);
    }
    let idx = getIndex(0, this.tricks.length);
    console.log(`${this.name} is ${this.tricks[idx]}!`);
}

// Dumbo.play();

// PHASE 3: Function Invocation
let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

let herd = [ellie, charlie, kate, micah];

Elephant.paradeHelper = function(elephant) {
    console.log(`${elephant.name} is trotting by!`);
}
herd.forEach(elephant => Elephant.paradeHelper(elephant));

// PHASE 4: Closures
function dinerBreakfast(){
    let orders = ["cheesy scrambled eggs"];
    
    function printOrder() { console.log(`I would like ${orders.join(' and ')} please.`) }
    printOrder();

    return function addOrder(food){
        orders.push(food);
        printOrder();
    }
}


let bfastOrder = dinerBreakfast();
// "I'd like cheesy scrambled eggs please"
bfastOrder("chocolate chip pancakes");
// "I'd like cheesy scrambled eggs and chocolate chip pancakes please."
bfastOrder("grits");
// "I'd like cheesy scrambled eggs and chocolate chip pancakes and grits please."