import React from 'react';

class Clock extends React.Component {
    constructor (props) {
        super(props);
        this.state = { time: new Date () };
        this.tick = this.tick.bind(this);
    }

    // Need to bind, otherwise undefined
    tick () {
        this.setState({ time: new Date ()});
    }

    // invoke immediately after component mounted
    componentDidMount() {
        this.intervalId = setInterval(this.tick, 1000);
    }

    componentWillUnmount() {
        clearInterval(this.interalId);
    }

    render() {
        const month = this.state.time.getMonth();
        const day = this.state.time.getDate();
        const year = this.state.time.getFullYear();
        const hour = this.state.time.getHours();
        const minute = this.state.time.getMinutes();
        const second = this.state.time.getSeconds();
        return (
            <div>
                <h1>Clock</h1>
                <ul>
                    <li>Date: {month} / {day} / {year}</li>
                    <li>Time: {hour} : {minute} : {second}</li>
                </ul>
            </div>
        )
    }
}

export default Clock;