import React from 'react';

class StepListItem extends React.Component {
    constructor(props) {
        super(props);
        this.toggleDone = this.toggleDone.bind(this);
    }

    toggleDone(e) {
        e.preventDefault();
        const toggleStep = Object.assign({}, this.props.step)
        toggleStep.done = !toggleStep.done;
        this.props.receiveStep(toggleStep);
    }

    render() {
        const { removeStep } = this.props;
        const { title, body, done } = this.props.step;
        return (
            <li>
                <span>{title}</span>
                <span>{body}</span>
                <button onClick={removeStep}>Remove Step</button>
                <button onClick={this.toggleDone}>
                    {done ? "Undo" : "Done"}
                </button>
            </li>
        )
    }
}

export default StepListItem;