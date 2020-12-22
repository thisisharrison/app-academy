console.log("Hello from the JavaScript console!"); // This will log first

$.ajax({
    method: 'GET',
    url: 'http://api.openweathermap.org/data/2.5/weather?q=new%20york,US&appid=bcb83c4b54aee8418983c2aff3073b3b',
    dataType: 'json',
    success: function (resp) { console.log( resp );}, // These will log third
    error: function () { console.log(error); }
})

console.log("Another console log"); // This will log second
