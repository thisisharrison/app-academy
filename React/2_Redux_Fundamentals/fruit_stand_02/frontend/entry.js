import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';

import Store from './store';
// import { configureStore } from './store';
import { addOrange, addApple, removeOrange, removeApple, clearFruit } from './actions';
import FruitStandContainer from './components/fruit_stand_container';

// TODO just for testing!
// window.configureStore = configureStore;
window.store = Store;
window.addOrange = addOrange;
window.addApple = addApple;
window.removeOrange = removeOrange;
window.removeApple = removeApple;
window.clearFruit = clearFruit;

const App = () => (
	<Provider store={Store}>
		<FruitStandContainer />
	</Provider>
);

document.addEventListener("DOMContentLoaded", () => {
	ReactDOM.render(
		<App />,
		document.getElementById('root')
	);
});
