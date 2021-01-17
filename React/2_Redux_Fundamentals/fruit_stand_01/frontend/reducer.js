const reducer = (state = [], action) => {
  switch(action.type) {
    case 'ADD_FRUIT':
      return [
        ...state,
        action.fruit
      ];
    case 'REMOVE_FRUIT':
      const cloneFruit = Object.assign([],state);
      const idx = cloneFruit.indexOf(action.fruit);
      cloneFruit.splice(idx, 1);
      return cloneFruit;

    default:
      return state;
  }
};

export default reducer;
