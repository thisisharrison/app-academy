class Router {
    constructor (node, routes) {
        this.node = node;
        this.routes = routes;
    }

    start () {
        // if someone opens a link to a URL with a hash fragment
        // or if they refresh with a hash fragment,
        // the router will still update the DOM.
        this.render();
        // Event listener on hashchange
        window.addEventListener('hashchange', () => this.render());
    }

    activeRoute () {
        // Remove the # character
        const loc = window.location.hash.slice(1);
        // Returns a component
        return this.routes[loc];
    }

    render () {
        // get component of the current route
        const component = this.activeRoute();
        // no component returned
        if (!component) {
            this.node.innerHTML = '';
        } else {
            this.node.innerHTML = '';
            const domNode = component.render();
            this.node.appendChild(domNode);
        }
    }
}

module.exports = Router;
