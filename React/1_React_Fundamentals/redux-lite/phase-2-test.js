/*
// Test Case

// define a reducer for user:
const userReducer = (oldUser = null, action) => {
    if (action.type === "new user") {
        return action.user;
    }
    return oldUser;
};

// create a rootReducer:
const rootReducer = combineReducers({
    user: userReducer
});

// create a store using the rootReducer:
debugger
const store = new Store(rootReducer);

// get the state:
debugger
store.getState(); // => {user: null} // Set to its default at initialize

// invoke the dispatch function to update the user key:
const action = {
    type: "new user",
    user: "Jeffrey Fiddler"
};

debugger
store.dispatch(action);
debugger
store.getState(); // => { user: "Jeffrey Fiddler" } // Updates Successfully
*/