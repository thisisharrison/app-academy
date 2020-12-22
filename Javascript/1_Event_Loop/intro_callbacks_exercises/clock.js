class Clock {
    constructor() {
        // 1. Create a Date object.
        this.date = new Date ();
        // 2. Store the hours, minutes, and seconds.
        this.setTime();
        // 3. Call printTime.
        this.printTime();
        // 4. Schedule the tick at 1 second intervals.
        // 'this' in setInterval is the Timeout API, so we need to use bind
        setInterval(this._tick.bind(this), 1000);
    }

    setTime() {
        this.hours = this.date.getHours();
        this.minutes = this.date.getMinutes();
        this.seconds = this.date.getSeconds();
    }

    printTime() {
        // Format the time in HH:MM:SS
        const timeString = [this.hours, this.minutes, this.seconds].join(':');
        // Use console.log to print it.
        console.log(timeString);
    }

    _tick() {
        const past = this.date;
        // 1. Increment the time by one second.
        const present = past.setSeconds(past.getSeconds() + 1);
        this.date = new Date (present);
        // 2. Reset Hour Minute Second ivar
        this.setTime();
        // 3. Call printTime.
        this.printTime();
    }
}

const clock = new Clock();