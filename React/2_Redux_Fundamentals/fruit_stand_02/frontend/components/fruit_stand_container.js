import { connect } from 'react-redux';
import { addApple, addOrange, removeApple, removeOrange, clearFruit } from '../actions';
import FruitStand from './fruit_stand';

// Provide gave us the store state
// We (container) are making the props to be used in presentational components

const mapStateToProps = state => ({
  fruits: state.fruits
});

const mapDispatchToProps = dispatch => ({
  addApple: () => dispatch(addApple()),
  addOrange: () => dispatch(addOrange()),
  removeApple: () => dispatch(removeApple()),
  removeOrange: () => dispatch(removeOrange()),
  clearFruit: () => dispatch(clearFruit())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(FruitStand);
