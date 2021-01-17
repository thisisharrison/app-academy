import { 
    RECEIVE_CURRENT_USER, 
    LOGOUT_CURRENT_USER 
} from '../actions/session';

const _nullSession = {
    currentUser: null
}
const sessionReducer = (prevState = _nullSession, action) => {
    Object.freeze(prevState)
    switch (action.type) {
    case RECEIVE_CURRENT_USER:
        const currentUser = action.user;
        return Object.assign({}, { currentUser });
    case LOGOUT_CURRENT_USER:
        return _nullSession;
    default:
        return prevState;
    }
}
export default sessionReducer;