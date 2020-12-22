const View = require('./snake-view');

$(() => {
    console.log('ready');
    const rootEl = $('.grid');
    new View (rootEl);
});