// View the full problem and run the test cases at:
//  https://leetcode.com/problems/course-schedule/

function canFinish(numCourses, prerequisites) {
    // check if there a cycle exists or nodes pointing each other
    // create graphlist
    let graphList = buildGraph(prerequisites)
    let totalCourses = Object.keys(graphList).length

    // check if node is visited
    let visited = new Set ()
    // flag to see if eligible courses exist
    let eligible = true

    while (eligible) {
        eligible = false
        for (let course in graphList) {
            // empty array passed to every and Set, returns true
                // this is ideal because course doesn't have prereq, and we mark eligible
            let prereqVisit = graphList[course].every(pre => visited.has(pre))
            if (!visited.has(course) && prereqVisit) {
                eligible = true
                visited.add(course)
            }
        }
    }

    return visited.size === totalCourses
}

function buildGraph(list) {
    let graph = {}
    list.forEach((prereq) => {
        // unpack the subarray and format everything to string
        let [ course, pre ] = prereq.map(String)
        if (course in graph) {
            graph[course].push(pre)
        } else {
            graph[course] = [ pre ]
        }
        if (!(pre in graph)) {
            graph[pre] = []
        }
    })
    return graph
}


console.log(canFinish(1, []))

let numCourses = 2
let prerequisites = [[1,0]]
// Output: true

// console.log(canFinish(numCourses, prerequisites))

let numCourses2 = 2
let prerequisites2 = [[1,0],[0,1]]
// Output: false

// console.log(canFinish(numCourses2, prerequisites2))

let numCourses3 = 20
let prerequisite3 = [[0,10],[3,18],[5,5],[6,11],[11,14],[13,1],[15,1],[17,4]]
// Output: false

// console.log(canFinish(numCourses3, prerequisite3))

/*
graphList = {
    course: [prerequisites]
}
*/