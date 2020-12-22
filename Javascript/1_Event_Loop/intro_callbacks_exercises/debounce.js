Function.prototype.myDebounce = function (interval) {
    let timeout;

    return (...args) => {
        
        // a function that resets timeout and calls the function
        const fnCall = () => {
            timeout = null;
            this(...args);
        }

        // clear pre-existing timeout
        clearTimeout(timeout);
        // create new timeout
        timeout = setTimeout(fnCall, interval);
    }
}

class SearchBar {
    constructor() {
        this.query = "";

        this.type = this.type.bind(this);
        this.search = this.search.bind(this);
    }

    type(letter) {
        this.query += letter;
        this.search();
    }

    search() {
        console.log(`searching for ${this.query}`);
    }
}

const searchBar = new SearchBar();

const queryForHelloWorld2 = () => {
    searchBar.type("h");
    searchBar.type("e");
    searchBar.type("l");
    searchBar.type("l");
    searchBar.type("o");
    searchBar.type(" ");
    const delay = function() {setTimeout(()=>{
        searchBar.type("w");
        searchBar.type("o");
        searchBar.type("r");
        searchBar.type("l");
        searchBar.type("d");    
    }, 3000)}
    delay()
    
    
    clearTimeout(delay)
};

// Original version
// queryForHelloWorld2();
// searching for h
// searching for he
// searching for hel
// searching for hell
// searching for hello
// searching for hello ... ... pauses for 3 sec
// searching for hello w
// searching for hello wo
// searching for hello wor
// searching for hello worl
// searching for hello world

// Debounced version
// Prevented many wasteful searches by only searching when user stops typing for at least 1000ms
searchBar.search = searchBar.search.myDebounce(1000);
queryForHelloWorld2();
// searching for hello ... ... pauses for 3 sec
// searching for hello world
