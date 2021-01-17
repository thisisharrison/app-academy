import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Redirect, Route, withRouter } from 'react-router-dom';

const mapStateToProps = state => ({
    loggedIn: Boolean(state.session.currentUser)
});

// We'll pass down a path, a component to Auth
// <AuthRoute path = "", component = {} />
// We need to capitalize Component
// render is a function that returns Redirect or Component
const Auth = ({ loggedIn, path, component: Component }) => (
    <Route 
        path = {path}
        render = { props => (
            loggedIn ? <Redirect to="/" /> : <Component {...props} />
        )}
    />
);

const Protected = ({ loggedIn, path, component: Component }) => (
    <Route 
        path = {path}
        render = { props => (
            loggedIn ? <Component {...props} /> : <Redirect to="/signup" />
        )}
    />
);

// withRouter gives us location, history and match
export const AuthRoute = withRouter(connect(mapStateToProps)(Auth));
export const ProtectedRoute = withRouter(connect(mapStateToProps)(Protected));