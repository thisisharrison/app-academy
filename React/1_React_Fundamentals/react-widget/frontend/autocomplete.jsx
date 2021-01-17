import React from 'react';

import ReactCSSTransitionGroup from 'react-addons-css-transition-group';

class Autocomplete extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            inputVal: '',
            length: 0
        }
        this.updateSearch = this.updateSearch.bind(this);
        this.finishSearch = this.finishSearch.bind(this);
    }

    updateSearch (e) {
        const value = e.target.value;
        this.setState({ inputVal: value, length: value.length });
    }

    finishSearch (e) {
        const value = e.currentTarget.innerText;
        this.setState({ inputVal: value, length: value.innerText });
    }

    render() {
        const friends = this.props.names.filter(name => 
            name.substring(0, this.state.length).toLowerCase() === this.state.inputVal)
            .map((name, index) => (
                <li key={index} onClick={(e) => this.finishSearch(e)}>{name}</li>
            ))
        
        return(
            <div>
                <h1>Autocomplete</h1>
                <input type="text" value={this.state.inputVal} onChange={(e) => this.updateSearch(e)}/>
                <ul>
                    <ReactCSSTransitionGroup
                        transitionName="auto"
                        transitionEnterTimeout={500}
                        transitionLeaveTimeout={500}>
                    {friends}
                    </ReactCSSTransitionGroup>
                </ul>
            </div>
        );
    }
}

export default Autocomplete;