import { ADD_FRUIT, REMOVE_FRUIT, CLEAR } from "./actions";

const _defaultState = {
  fruits: []
}

const reducer = (oldState = _defaultState, action) => {
  switch(action.type) {
    case ADD_FRUIT:
      return {
        fruits: [
          ...oldState.fruits,
          action.fruit
        ]
      };
    case REMOVE_FRUIT: 
      let cloneFruits = Object.assign([],oldState.fruits);
      const idx = cloneFruits.indexOf(action.fruit);
      cloneFruits.splice(idx, 1)
      return {
        fruits: [...cloneFruits]
      }
    case CLEAR:
      return _defaultState;
    default:
      return oldState;
  }
}

export default reducer;
