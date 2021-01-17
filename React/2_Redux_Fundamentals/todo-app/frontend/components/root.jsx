// Wrap App component with a react-redux Provider

import React from 'react';
import { Provider } from 'react-redux';
import App from './app';

// It receives props as argument 
// Prop will be redux store passed down from entry file (todo_redux)
const Root = ({ store }) => (
    <Provider store={store}> 
        <App />
    </Provider>
);

export default Root;