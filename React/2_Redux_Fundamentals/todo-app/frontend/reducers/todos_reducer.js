import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO } from '../actions/todo_actions';


const todosReducer = (oldState = sampleList, action) => {
  let newState = {};
  Object.freeze(oldState);
  
  switch(action.type) {
    // Replace old todos
    case RECEIVE_TODOS:
      action.todos.forEach(todo => {
        newState[todo.id] = todo;
      })
      return newState;
    
    // Add or update a todo
    case RECEIVE_TODO:
      let idx = action.todo.id;
      newState = Object.assign({}, oldState);
      newState[idx] = action.todo;
      return newState;

    case REMOVE_TODO:
      newState = Object.assign({}, oldState);
      delete newState[action.todo.id];
      return newState

    default: 
      return oldState;
  }
}

export default todosReducer;


// State Shape
// todo.id is object key and primary identifier
const sampleList = {
  1: {
    id: 1,
    title: 'wash car',
    body: 'with soap',
    done: false
  },
  2: {
    id: 2,
    title: 'wash dog',
    body: 'with shampoo',
    done: true
  },
}

const _defaultState = {
  0: {
    id: 0,
    title: 'What is on your mind?',
    body: 'Empty your to-dos here!',
    done: false
  }
}
