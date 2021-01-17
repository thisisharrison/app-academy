import { RECEIVE_STEPS, RECEIVE_STEP, REMOVE_STEP } from '../actions/step_actions';

const stepsReducer = (oldState = sampleSteps, action) => {
    let newState;
    Object.freeze(oldState);

    switch (action.type) {
        case RECEIVE_STEPS: 
            newState = Object.assign({}, oldState);
            action.steps.forEach(step => newState[step.id] = step);
            return newState;
        case RECEIVE_STEP:
            newState = Object.assign({}, oldState, { [action.step.id]: action.step });
            return newState;
        case REMOVE_STEP:
            newState = Object.assign({}, oldState);
            delete newState[action.step.id];
            return newState;
        default: 
            return oldState;
    }
}

export default stepsReducer;

// Sample State Shape
const sampleSteps = {
  1: { 
    id: 1,
    title: 'walk to store',
    body: 'walk faster',
    done: false,
    todo_id: 1
    },
  2: { 
    id: 2,
    title: 'buy soap',
    body: 'soapier the better',
    done: false,
    todo_id: 1
    }
};

const defaultSteps = {
    0: {
        id: 0,
        title: "add some steps here",
        body: "make it detailed",
        done: false,
        todo_id: 0
    }
}
