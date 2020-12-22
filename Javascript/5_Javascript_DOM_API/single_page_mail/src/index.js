const Compose = require('./compose');
const Inbox = require('./inbox');
const Router = require('./router');
const Sent = require('./sent');

const routes = {
    "": Inbox,
    inbox: Inbox,
    sent: Sent,
    compose: Compose
}


document.addEventListener('DOMContentLoaded', () => {

    const sideBar = document.querySelector('.sidebar-nav');

    sideBar.addEventListener('click', (event) => {
        const loc = event.target.innerText.toLowerCase();
        window.location.hash = loc;
    })

    const content = document.querySelector('.content');
    const router = new Router (content, routes);
    router.start();
    // immediately route to inbox
    window.location.hash = "#inbox";

});
