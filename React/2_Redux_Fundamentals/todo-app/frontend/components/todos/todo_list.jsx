import React from 'react';
import { connect } from 'react-redux';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

// props has todos and dispatch actions from mapStateToProps from redux state
const TodoList = ({ todos, receiveTodo, removeTodo }) => {
    const list = todos.map((todo, idx) => <TodoListItem todo={todo} 
                                                        key={todo.id} 
                                                        removeTodo={removeTodo}
                                                        receiveTodo={receiveTodo}/>);
    return (
    <div>
        <TodoForm receiveTodo={receiveTodo} />
        <ul>
            {list}
        </ul>
    </div>
    )
}

export default TodoList; 