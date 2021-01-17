// Getter methods for the application state
// Receive state as an argument
// Return a subset of state data formatted in a specific way

// destructor reducer's todos
export const allTodos = ({ todos }) => {
    return Object.keys(todos).map(id => todos[id] );
}

// destructor reducer's steps
export const stepsByTodoId = ({ steps }, todoId) => {
    return Object.keys(steps).filter(id => steps[parseInt(id)].todo_id === parseInt(todoId))
                            .map(id => steps[parseInt(id)]);
}


// Debugging
// window.allTodos = allTodos;
// window.stepsByTodoId = stepsByTodoId;