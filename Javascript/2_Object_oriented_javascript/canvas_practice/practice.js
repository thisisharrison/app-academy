document.addEventListener("DOMContentLoaded", function(){
    const canvas = document.getElementById('mycanvas');
    canvas.width = 500;
    canvas.height = 500;
    const ctx = canvas.getContext('2d');

    ctx.fillStyle = "blue";
    ctx.fillRect(25, 25, 100, 100);
    
    // Invoke circle
    ctx.beginPath();
    // Draws Circle
    ctx.arc(50, 50, 12.5, 0, 2 * Math.PI);
    // Set Color
    ctx.strokeStyle = "yellow";
    // Set Width
    ctx.lineWidth = 10;
    // Draws Line
    ctx.stroke();
    // Set Color
    ctx.fillStyle = "red";
    // Fill Circle
    ctx.fill();

    ctx.beginPath();
    ctx.arc(100, 100, 12.5, 0, 2 * Math.PI);
    ctx.strokeStyle = "red";
    ctx.lineWidth = 10;
    ctx.stroke();
    ctx.fillStyle = "yellow";
    ctx.fill();
});
