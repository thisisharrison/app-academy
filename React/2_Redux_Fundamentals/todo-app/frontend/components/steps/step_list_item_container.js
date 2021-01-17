import { connect } from 'react-redux';
import { receiveStep, removeStep } from '../../actions/step_actions';
import StepListItem from './step_list_item';

// step passed from step_list
const mapDispatchToProps = (dispatch, {step}) => ({
    removeStep: () => dispatch(removeStep(step)),
    receiveStep: step => dispatch(receiveStep(step))
});

export default connect(null, mapDispatchToProps)(StepListItem);