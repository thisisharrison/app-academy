class Store {
    constructor(rootReducer, appliedMiddleware) {
        // reducers, how state data will change in response to action
        // actions, change to be made to state
        this.rootReducer = rootReducer;
        this.appliedMiddleware = appliedMiddleware;
        // The global state, keys representing application data
        // Get keys and set to default with empty action 
        this.state = this.dispatch({});
        // An array of callback functions that trigger when global state changes
        this.subscriptions = [];
    }

    getState() {
        // Prevent users from modifying the actual state
        const cloneState = Object.assign(this.state);
        return cloneState;
    }

    dispatch(action) {
        this.appliedMiddleware(this, action => {
            this.state = this.rootReducer(this.state, action, this.subscriptions);
            return this.state;
        })(action);
    }

    subscribe(callback) {
        this.subscriptions.push(callback);
    }
}

function combineReducers(reducers) {
    // reducers is an object with key state pointing to the reducer that updates the state
    // return a single reducer
    return (prevState, action, subscriptions) => {
        let nextState = {};
        // listen for changes 
        let hasModified = false;
        for (let key in reducers) {
            if (emptyAction(action)) {
                const args = [, { type: "__doesNotMatter" }]; // at initialize doesn't matter what type
                nextState[key] = reducers[key](...args); // destructure array to obj arg
                hasModified = true;
            } else {
                let oldValue = prevState[key];
                // combineReducers' key equals key's reducer function with old state and action as args
                nextState[key] = reducers[key](oldValue, action, subscriptions);
                if (prevState[key] !== nextState[key]) hasModified = true;
            }
        }
        if (hasModified) {
            if (subscriptions) {
                // trigger all callbacks if changes to global state was made
                subscriptions.map(cb => cb(nextState));
            }
            // Single reducer responsible for global state
            return nextState;
        } else {
            // no changes were made
            return prevState;
        }
    }
}

const appliedMiddleware = (...middlewares) => (store, rootReducer) => action => {
    // clone middlewares
    const cloneMiddlewares = [...middlewares];
    const invokeNextMiddleware = (action) => {
        let nextMiddleware = cloneMiddlewares.shift();
        if (!nextMiddleware) {
            return rootReducer(action);
        }
        return nextMiddleware(store)(invokeNextMiddleware)(action);
    };
    return invokeNextMiddleware(action);
}

const logger = store => next => action => {
    const prevState = store.getState();
    const nextState = next(action);

    console.log("%c prevState: ", "color: purple; font-size: 20px;");
    console.log(prevState);
    console.log("%c action: ", "color: blue; font-size: 20px;");
    console.log(action);
    console.log("%c nextState: ", "color: green; font-size: 20px;")
    console.log(nextState);
}