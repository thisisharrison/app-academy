Function.prototype.myThrottle = function (interval) {
    let tooSoon = false

    return (arguments) => {
        if (!tooSoon) {
            tooSoon = true;
            setTimeout(() => tooSoon = false, interval);
            this(arguments);
        }
    }
}

class Neuron {
    fire() {
        console.log("Firing!");
    }
}

const neuron = new Neuron();

const interval = setInterval(() => {
    neuron.fire();
}, 10);

clearInterval(interval);

// it can only fire once every 5000ms even though we set it to every 10ms 
neuron.fire = neuron.fire.myThrottle(5000);

const interval2 = setInterval(() => {
    neuron.fire();
}, 10);

clearInterval(interval2)