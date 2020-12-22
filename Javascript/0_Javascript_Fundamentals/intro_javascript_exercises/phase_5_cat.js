function Cat(name, owner) {
    this.name = name;
    this.owner = owner;
}

Cat.prototype.cuteStatement = function(){
    console.log(`${this.owner} loves ${this.name}`);
}

const garfield = new Cat ('garfield', 'jon');
const sadCat = new Cat('blue', 'bob');

garfield.cuteStatement();
// jon loves garfield

Cat.prototype.cuteStatement = function() {
    console.log(`Everyone loves ${this.name}`);
}

garfield.cuteStatement();
// Everyone loves garfield

Cat.prototype.meow = function(){
    console.log('meow');
}

garfield.meow();

// Method defined on the instance override those defined on the prototype
sadCat.meow = function(){
    console.log('sad meow')
}

sadCat.meow();
// sad meow
garfield.meow();
// meow