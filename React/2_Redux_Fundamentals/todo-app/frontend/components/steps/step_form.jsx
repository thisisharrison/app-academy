import React from 'react';
import { uniqueId } from '../../util/util';

class StepForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            title: "",
            body: "",
            done: false,
            todo_id: this.props.todo_id
        }
        this.handleInput = this.handleInput.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleInput(key) {
        return e => this.setState({ [key]: e.target.value});
    }

    handleSubmit(e) {
        e.preventDefault();
        const newStep = Object.assign({}, this.state, {id: uniqueId()});
        this.props.receiveStep(newStep);
        this.setState({
            title: "",
            body: ""
        });
    }
        
    render() {
        return (
            <form onSubmit={this.handleSubmit}>
                <label htmlFor="step-title">Title</label>
                <input type="text" 
                        id="step-title" 
                        onChange={this.handleInput('title')} 
                        value={this.state.title} />
                <label htmlFor="step-body"></label>
                <textarea id="step-body" 
                        cols="20" 
                        rows="10" 
                        onChange={this.handleInput('body')}
                        value={this.state.body}></textarea>
                <input type="submit" value="Submit"/>
            </form>
        )
    }
}

export default StepForm;