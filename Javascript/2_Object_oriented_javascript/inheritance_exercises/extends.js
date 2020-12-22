// Extends
class Animal {
    constructor(name) {
        this.name = name;
    }
    eat() {
        return "...mmm food";
    }
}

class Dog extends Animal {
    constructor(name, snack) {
        super(name);
        this.snack = snack;
    }

    eat() {
        const oldEat = super.eat();
        console.log(`${oldEat}, I want ${this.snack}`);
    }
}

class Cat extends Animal {
    constructor(name) {
        super(name);
    }

    meow() {
        console.log('meow');
    }
}

const d = new Dog ('george', 'bone');
const c = new Cat ('garfield');

console.log(c.eat()); // inherit eat()
d.eat(); // overwrite eat()
c.meow();
d.meow(); // error