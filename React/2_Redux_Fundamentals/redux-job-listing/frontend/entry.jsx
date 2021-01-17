import React from 'react';
import ReactDOM from 'react-dom';
import Widget from './components/widget';
// requires store
import store from './store';

/*
For testing:
import { selectLocation } from './actions';

console.clear()
window.store = store;
window.selectLocation = selectLocation;
*/

document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(<Widget store={store} />, document.getElementById('root'));
});
