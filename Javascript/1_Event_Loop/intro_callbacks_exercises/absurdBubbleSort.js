const readline = require('readline');
const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
})

function absurdBubbleSort (arr, sortCompletionCallback) {
    function outerBubbleSortLoop(madeAnySwaps) {
        if (madeAnySwaps) {
            innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
        } else {
            sortCompletionCallback(arr);
        }
    }
    outerBubbleSortLoop(true);
}

function askIfGreaterThan (el1, el2, callback) {
    reader.question(`Is ${el1} greater than ${el2}?`, (ans) => {
        if (ans === 'yes') {
            callback(true);
        }
        callback(false);
    })
}

function innerBubbleSortLoop (arr, i, madeAnySwaps, outerBubbleSortLoop) {
    if (i < arr.length - 1) {
        askIfGreaterThan(arr[i], arr[i + 1], function (isGreaterThan) {
            if (isGreaterThan) {
                const temp = arr[i]
                arr[i] = arr[i + 1]
                arr[i + 1] = temp
                madeAnySwaps = true;    
            }
            i += 1;
            innerBubbleSortLoop (arr, i, madeAnySwaps, outerBubbleSortLoop);
        });
    } else if (i == (arr.length - 1)) {
        outerBubbleSortLoop(madeAnySwaps);
        return;
    }
}

absurdBubbleSort([3, 2, 1], function (arr) {
    console.log("Sorted array: " + JSON.stringify(arr));
    reader.close();
});

// Is 3 greater than 2 ? yes
// Is 3 greater than 1 ? yes
// Is 2 greater than 1 ? yes
// Is 2 greater than 3 ? no
// Is 1 greater than 2 ? no
// Is 2 greater than 3 ? no
// Sorted array: [1, 2, 3]