import React from 'react';

class Headers extends React.Component {
    render () {
        const folders = this.props.folders;
        // Map to get all the li's
        const headers = folders.map((folder, index) => {
            const title = folder.title;
            return (
                <li key={ index }
                    onClick={ (e) => this.props.onUpdateTab(index) } >
                    <h1>{title}</h1>
                </li>
            )
        })

        return (
            <ul>
                {headers}
            </ul>
        );
    }
}

class Tabs extends React.Component {
    constructor(props) {
        super(props);
        this.state = { tabIndex: 0 };

        this.onUpdateTab = this.onUpdateTab.bind(this);
    }

    // Passing the event call back to header
    onUpdateTab (index) {
        this.setState({ tabIndex: index })
    }

    render () {
        const currentContent = this.props.folders[this.state.tabIndex].content;
        return (
            <div>
                <h1>Tabs</h1>
                <Headers folders = {this.props.folders}
                    onUpdateTab = {this.onUpdateTab}>
                </Headers>
                <article>
                    {currentContent}
                </article>
            </div>
        );
    }
}

export default Tabs;
