import React from 'react';
import TodoDetailViewContainer from './todo_detail_view_container';

class TodoListItem extends React.Component {
    constructor(props) {
        super(props);
        this.toggleDone = this.toggleDone.bind(this);
        this.toggleDetail = this.toggleDetail.bind(this);
        this.state = {
            detail: false
        }
    }

    toggleDone(e) {
        e.preventDefault();
        let newState = Object.assign({}, this.props.todo);
        newState.done = !newState.done;
        // overwrite the todo
        this.props.receiveTodo(newState);
    }

    toggleDetail(e) {
        e.preventDefault();
        this.setState({detail: !this.state.detail});
    }

    render() {
        const { todo, removeTodo } = this.props;
        const { title, done } = todo;
        const detail = this.state.detail ? <TodoDetailViewContainer todo={todo}/> : ""
        return (
            <li>
                <span onClick={this.toggleDetail}>{title}</span>
                <button onClick={this.toggleDone}>
                    { done ? "Undo" : "Done"}
                </button>
                {detail}
            </li>
        )
    }
}
export default TodoListItem;