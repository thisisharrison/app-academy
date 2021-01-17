export const ADD_FRUIT = "ADD_FRUIT";
export const CLEAR = "CLEAR";
export const REMOVE_FRUIT = 'REMOVE_FRUIT'; 

export const addOrange = () => ({
  type: ADD_FRUIT,
  fruit: "Orange"
})

export const addApple = () => ({
  type: ADD_FRUIT,
  fruit: 'Apple'
});

export const removeOrange = () => ({
  type: REMOVE_FRUIT,
  fruit: "Orange"
})

export const removeApple = () => ({
  type: REMOVE_FRUIT,
  fruit: 'Apple'
});

export const clearFruit = () => ({
  type: CLEAR
});
