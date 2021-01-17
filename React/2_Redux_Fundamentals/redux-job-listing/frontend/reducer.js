import { SWITCH_LOCATION } from './actions';

// Default values in the case that state is not passed in 
const initialState = {
  city: "Please Select", 
  jobs: []
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case SWITCH_LOCATION: 
      return {
        city: action.city,
        jobs: action.jobs
      }
    default: 
      return state;
  }
};

// For Testing
// window.reducer = reducer;

export default reducer;
