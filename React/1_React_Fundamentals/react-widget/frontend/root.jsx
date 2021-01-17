import React from 'react';
import ReactDOM from 'react-dom';

import Clock from './clock';
import Tabs from './tabs';
import Weather from './weather';
import Autocomplete from './autocomplete';


const folders = [
    { title: 'one', content: 'folder 1' },
    { title: 'two', content: 'folder 2' },
    { title: 'three', content: 'folder 3' }
]

const names = [
    'Abba',
    'Barney',
    'Barbara',
    'Jeff',
    'Jenny',
    'Sarah',
    'Sally',
    'Xander'
];

class Root extends React.Component {
    render () {
        return (
            <div>
                <Clock />
                <Tabs folders={folders}/>
                <Weather />
                <Autocomplete names={names}/>
            </div>
        )
    }
}

export default Root;