import { createStore, applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';

// Redux store holds a reference to an app state
// Store handles updating state when actions are dispatched
// Tells the components to re-render

// Will come in handy with middlewares
const configureStore = (preloadedState = {}) => {
    const store = createStore(rootReducer, preloadedState, applyMiddleware(addLoggingToDispatch));
    store.subscribe(() => localStorage.state = JSON.stringify(store.getState()))
    return store;
}

// Middleware Experiment:
// delay's next is addLoggingToDispatch, addLoggingToDispatch's next is dispatch action
// const store = createStore(rootReducer, preloadedState, applyMiddleware(delay, addLoggingToDispatch));
// Logging
const addLoggingToDispatch = store => next  => action => {
    console.log('Old State');
    console.log(store.getState());
    console.log('Action');
    console.log(action);
    // next is the dispatch function
    next(action)
    console.log('Logging\'s next: ', next);
    console.log('New State');
    console.log(store.getState());
}
// Delaying
// const delay = store => next => action => {
//     console.log('Timeout Starts')
//     console.log('Timeout\'s next: ', next);
//     setTimeout(()=>{
//         next(action);
//         console.log('Timeout Finish')
//     }, 5000);
// }



export default configureStore;

