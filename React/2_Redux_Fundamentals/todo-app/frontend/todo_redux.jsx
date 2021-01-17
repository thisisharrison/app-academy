import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';


document.addEventListener('DOMContentLoaded', () => {
    const preloadedState = localStorage.state ? JSON.parse(localStorage.state) : {};
    let store = configureStore(preloadedState);
    
    // Phase 1: Logging
    // anti-pattern, would like to avoid 
    // store.dispatch = addLoggingToDispatch(store);

    // Phase 2: applyMiddlewares
    // store = _applyMiddlewares(store, addLoggingToDispatch);

    // Phase 3: redux's applyMiddleware (in store.js)

    const content = document.getElementById('content');
    ReactDOM.render(<Root store={store} />, content);
})

// Phase 1: Logging
// const addLoggingToDispatch = (store) => {
//     const storeDispatch = store.dispatch;
//     return (action) => {
//         console.log('Old State');
//         console.log(store.getState());
//         console.log('Action');
//         console.log(action);
//         storeDispatch(action);
//         console.log('New State')
//         console.log(store.getState());
//     }
// };

// Phase 2: applyMiddlewares
// Run either a single middleware of a group of middlewares 
// Give middlewares access to the store's dispatch function and action
// addLoggingToDispatch returns a func that receives next middleware as an argument
// inner function return another function that receives the action argument
// const addLoggingToDispatch = store => next  => action => {
//     console.log('Old State');
//     console.log(store.getState());
//     console.log('Action');
//     console.log(action);
//     next(action)
//     console.log('What\'s next? ', next)
//     // next is the dispatch function
//     console.log('New State')
//     console.log(store.getState());
// }


// // Receives the store and list of middlewares
// const _applyMiddlewares = (store, ...middlewares) => {
//     // Overwrites the dispatch method to call all middlewares when dispatching action
//     let dispatch = store.dispatch;
//     middlewares.forEach((middle) => {
//         // adding the next(action) to dispatch
//         dispatch = middle(store)(dispatch)
//     })
//     return Object.assign({}, store, { dispatch });
// }