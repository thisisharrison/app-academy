const Util = {
    inherits(childClass, parentClass) {
        childClass.prototype = Object.create(parentClass.prototype);
        childClass.constructor = childClass;
    },
    
    // Return a randomly oriented vector with the given length.
    randomVec(length) {
        const deg = 2 * Math.PI * Math.random();
        return Util.scale([Math.sin(deg), Math.cos(deg)], length);
    },
    
    // Scale the length of a vector by the given amount.
    scale(vec, m) {
        return [vec[0] * m, vec[1] * m];
    },

    wrap (coor, max) {
        let newCoor;
        // eg. wrap(11, 10) = 11 % 10 = 1 
        if (coor > max) {
            newCoor = coor % max;
        } 
        // eg. wrap(-1, 10) = 10 - (-1 % 10) = 11
        else if (coor < 0) {
            newCoor = max - (coor % max);
        } else {
            newCoor = coor;
        }
        return newCoor;
    },

    // Find distance between two points
    distance (pos1, pos2) {
        // pow - pow(base, exponent)
        return Math.sqrt(Math.pow((pos2[0] - pos1[0]), 2) + Math.pow((pos2[1] - pos1[1]), 2));
    },
    // Normalize lenght of vector to 1, maintain direction
    direction (vector) {
        const norm = Util.normalize(vector);
        return Util.scale(vector, 1 / norm);
    }, 
    // Find length of vector
    normalize (vector) {
        return Util.distance([0, 0], vector);
    }

}

module.exports = Util;