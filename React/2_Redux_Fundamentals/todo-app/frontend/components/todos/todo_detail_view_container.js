// Container component
import { connect } from "react-redux";
import { removeTodo } from "../../actions/todo_actions";
import { receiveSteps } from '../../actions/step_actions';
// React Component
import TodoDetailView from './todo_detail_view';

// todo passed in todo_list_item
const mapDispatchToProps = (dispatch, { todo }) => ({
    removeTodo: () => dispatch(removeTodo(todo)),
    receiveSteps: (steps) => dispatch(receiveSteps(steps))
})

// Connect to the detail view React component
export default connect(null, mapDispatchToProps)(TodoDetailView);