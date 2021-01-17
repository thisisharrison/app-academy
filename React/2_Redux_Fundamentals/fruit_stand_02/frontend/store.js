import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import logger from 'redux-logger';
import { composewithDevTools } from 'redux-devtools-extension';

import reducer from './reducer.js';


const Store = createStore(reducer);
// const configureStore = () => (
//     createStore(reducer,
//             composewithDevTools(
//                 applyMiddleware(thunk, logger)
//             ))
// );

export default Store;
