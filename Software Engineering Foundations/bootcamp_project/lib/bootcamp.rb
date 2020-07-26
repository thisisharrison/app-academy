class Bootcamp
    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity 
        @teachers = []
        @students = []
        @grades = Hash.new { |h, k| h[k] = [] }
    end

    def name
        @name
    end

    def slogan
        @slogan
    end

    def teachers
        @teachers
    end

    def students
        @students
    end

    def hire(teacher)
        @teachers << teacher
    end

    def enroll(student)
        if @students.length < @student_capacity
            @students << student
            return true
        else
            return false
        end
    end

    def enrolled?(student)
        @students.include?(student)
    end

    def student_to_teacher_ratio
        @students.length / @teachers.length
    end

    def add_grade(student, grade)
        if self.enrolled?(student) # works without self# but include to separate functions outside of class
            @grades[student] << grade
            return true
        else
            false
        end
    end

    def num_grades(student)
        if self.enrolled?(student)
            return @grades[student].length
        else
            false
        end
    end

    def average_grade(student)

        return nil if !self.enrolled?(student) || self.num_grades(student).zero? # check if student enrolled and if we will divide by 0 
        # if above false, return average
        @grades[student].sum / self.num_grades(student)

        # if self.enrolled?(student)
        #     total = @grades[student].sum
        #     grades = num_grades(student)
        #     if grades == 0
        #         return nil
        #     else
        #         return total / grades
        #     end
        # else
        #     nil
        # end
    end

end
