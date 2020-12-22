const DOMNodeCollection = require('./dom_node_collection');


// To collect callbacks when Doc Ready
const _docReadyCallbacks = [];
let _docReady = false;

// $l takes HTML element as arg
// if not HTML element (i.e. selector), query select from DOM first
// then create DOMNodeCollection instance

window.$l = (arg) => {
    switch (typeof arg) {
        // selector (css and html)
        case 'string': 
            return getNodeFromDOM(arg);

        case 'object': 
            // single HTML or NodeList
            if (arg instanceof HTMLElement) {
                return new DOMNodeCollection([arg]);
            } 

        case 'function': 
            return addFunctionQueue(arg);
    }
}

$l.merge = (defaults, options) => {
    for (const k in defaults) {
        for (const j in options) {
            if (options[k]) continue;
            options[k] = defaults[k];
        }
    }
    return options;
}

$l.ajax = (options) => {
    const request = new XMLHttpRequest();
    const defaults = {
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', // From jquery docs
        method: 'GET',
        url: '',
        data: {},
        success: () => { },
        error: () => { }
    }
    $l.merge(defaults, options);
    
    // Add search params from data to URL
    // if (options.method === 'GET') {
    //     options.url = queryParam(options.data);
    // }

    request.open(options.method, options.url, true);

    request.onload = (event) => {
        // Invoke success and error callbacks
        if (request.status === 200) {
            options.success(request.response);
        } else {
            options.error(request.response);
        }
    }

    // Send the ajax request
    request.send(JSON.stringify(options.data));
}

function queryParam (data) {
    let params = "?"
    for (const prop in data) {
        params += `${prop}=${data[prop]}&`;
    }
    // Remove last &
    return params.substring(0, params.length - 1);
}


getNodeFromDOM = (arg) => {
    const nodes = document.querySelectorAll(arg);
    const nodesArray = Array.from(nodes);
    return new DOMNodeCollection(nodesArray);
}

addFunctionQueue = (func) => {
    if (!_docReady) {
        _docReadyCallbacks.push(func)
    } else {
        func();
    }
}

document.addEventListener('DOMContentLoaded', () => {
// For _docReady
    _docReady = true;
    _docReadyCallbacks.map(func => func());

    $l.ajax({
        url: "http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=bcb83c4b54aee8418983c2aff3073b3b",
        dataType: 'json',
        success: (resp) => renderResponse(resp),
        error: (resp) => console.log(resp)
    })

// For Testing
    window.$div = $l('div');
    window.$h1 = $l('h1');
    window.$p = $l('p');
    window.$ul = $l('ul');
    window.$li = $l('li');
    window.$class = $l('.class');
    window.$id = $l('#id');
    window.$checkbox = $l('input[name="checkbox"]');
});

// Testing out Document Ready
// $l(()=> alert('ready'));

// Testing out AJAX
const renderResponse = (resp) => {
    const p = document.createElement('p');
    p.innerHTML = resp;
    document.querySelector('body').append(p);
}
