// Top-level concerns/components 
// Not nested under any other features
// Doesn't need to use any lifecycle hooks
// Doesn't rely on any of its props
// Doesn't need to receive any arguments

import React from 'react';
import TodoListContainer from './todos/todo_list_container';

const App = () => (
    <TodoListContainer />
)

export default App;