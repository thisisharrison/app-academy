import React from 'react';

// This react component is connected to the store via fruit_stand_container

// We received props from container
// we have mapped the store state as props with mapStateToProps
// we have mapped action creators and dispatch with mapDispatchToProps

// we destructure these from props
const FruitStand = ({fruits, addApple, addOrange, removeApple, removeOrange, clearFruit}) => (
  <div>
    <ul>
      {fruits.map((fruit, idx) => <li key={idx}>{fruit}</li>)}
    </ul>

    <button onClick={addApple}>Apple</button>
    <button onClick={addOrange}>Orange</button>
    <button onClick={removeApple}>Remove Apple</button>
    <button onClick={removeOrange}>Remove Orange</button>
    <button onClick={clearFruit}>Clear</button>
  </div>
)

export default FruitStand;
