// Controlled inputs and keep track of its state
// Have its local state
// props include todos and receiveTodo

import React from 'react';
import { uniqueId } from '../../util/util';

class TodoForm extends React.Component {
    constructor(props) {
        super(props);
        // Its local state and manage controlled inputs 
        this.state = {
            title: "",
            body: "",
            done: false
        };
        this.handleInput = this.handleInput.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleInput(key) {
        return e => this.setState({ [key] : e.target.value });
    }

    handleSubmit(e) {
        e.preventDefault();
        const newTodo = Object.assign({}, this.state, { id: uniqueId() });
        // dispatch redux action
        this.props.receiveTodo(newTodo);
        // reset form
        this.setState({
            title: "",
            body: ""
        });
    }

    render () {
        return (
            <form onSubmit={this.handleSubmit}>
                <h3>Add Todo!</h3>
                <label htmlFor="title">Title</label>
                <input type="text" 
                        id="title" 
                        value={this.state.title} 
                        placeholder="Finish a/A"
                        onChange={this.handleInput('title')} />

                <label htmlFor="body">Body</label>
                <textarea 
                        id="body" 
                        cols="20" 
                        rows="10"
                        placeholder="Final project and interview prep"
                        value={this.state.body}
                        onChange={this.handleInput('body')}></textarea>

                <input type="submit" 
                        value="Add"/>
            </form>
        )
    }
}

export default TodoForm;