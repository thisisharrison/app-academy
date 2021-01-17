import React from 'react';
import StepListContainer from '../steps/step_list_container';

// Display steps for an item
// Form to create new steps

class TodoDetailView extends React.Component {
    render() {
        const {todo, removeTodo} = this.props;
        return (
            <div>
                <h3>Detail</h3>
                <p>{todo.body}</p>
                <button onClick={removeTodo}>Remove</button>
                <StepListContainer todo_id={todo.id}/>
            </div>
        )
    }
}

export default TodoDetailView;