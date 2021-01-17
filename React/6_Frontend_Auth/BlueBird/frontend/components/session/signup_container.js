import { connect } from 'react-redux';
import { createNewUser } from '../../actions/session';
import SignUp from './signup';

const mapDispatchToProps = dispatch => ({
    createNewUser: (userForm) => dispatch(createNewUser(userForm))
})

// const mapStateToProps = state => ({

// })

export default connect(null, mapDispatchToProps)(SignUp);