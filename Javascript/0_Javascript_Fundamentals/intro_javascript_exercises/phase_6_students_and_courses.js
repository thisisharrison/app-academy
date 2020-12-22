function Student(first_name, last_name){
    this.first_name = first_name;
    this.last_name = last_name;
    this.courses = [];
}

Student.prototype.name = function(){
    return this.first_name.concat(' ', this.last_name);
}

Student.prototype.enroll = function(otherCourse){
    if (!this.courses.includes(otherCourse) && !this.hasConflict(otherCourse)){
        this.courses.push(otherCourse);
        otherCourse.addStudent(this);
    }
}

Student.prototype.courseLoad = function () {
    const hash = {};
    this.courses.forEach((course) => {
        if (hash[course.department]){
            hash[course.department] += course.credits;
        } else {
            hash[course.department] = course.credits;
        }
    })
    return hash;
}

Student.prototype.hasConflict = function(otherCourse){
    this.courses.forEach(c => {
        if (c.conflictsWith(otherCourse)){
            throw "Course conflict";
        }
    })
}


function Course(name, department, credits, days, time){
    this.name = name;
    this.department = department;
    this.credits = credits;
    this.students = [];
    this.days = days;
    this.time = time;
}

Course.prototype.addStudent = function(student){
    if(!(this.students.includes(student))){
        this.students.push(student);
        student.enroll(this);
    }
}

Course.prototype.conflictsWith = function(secondCourse){
    // Array.prototype.some - at least one past callback - Ruby's Array#any?
    let dayConflict = this.days.some(day => secondCourse.days.indexOf(day) !== -1 );
    let timeConflict = this.time == secondCourse.time;
    return dayConflict && timeConflict;
}


let student1 = new Student("Nigel", "Leffler");
let course1 = new Course("101", "CS", 3, ["mon", "wed", "fri"], 1);
let course2 = new Course("201", "CS", 3, ["wed"], 1);
let course3 = new Course("301", "ENG", 3, ["tue"], 1);
let course4 = new Course("401", "BIO", 3, ["mon", "wed", "fri"], 2);
console.log(student1.name());
student1.enroll(course1);
student1.enroll(course3);
student1.enroll(course2);
// Thrown: 'Course conflict'
console.log(student1.courseLoad());
// { CS: 3, ENG: 3 }
console.log('should be true = ' + course1.conflictsWith(course2));
// should be true = true
console.log('should be false = ' + course1.conflictsWith(course3));
// should be false = false
console.log('should be false = ' + course1.conflictsWith(course4));
// should be false = false