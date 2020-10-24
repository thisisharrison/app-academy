class User < ApplicationRecord

    # a user can have many enrollment
    has_many :enrollments,
        primary_key: :id,
        foreign_key: :student_id,
        class_name: :Enrollment

    # there isn't a 'belongs_to' assoication that is direct inverse of this one
    # we need to write where clause
    # student has many courses THROUGH enrollment
    # many to many relation
    
    has_many :enrolled_courses,
        through: :enrollments,
        source: :course

#   User.first.enrolled_courses
#   SELECT "courses".* 
#   FROM "courses" 
#   INNER JOIN "enrollments" 
#   ON "courses"."id" = "enrollments"."course_id" 
#   WHERE "enrollments"."student_id" = $1 
end
