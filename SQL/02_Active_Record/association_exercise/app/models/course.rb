class Course < ApplicationRecord

    # record is pointed to by Enrollment records 
    # so we use has_many

    has_many :enrollments,
        primary_key: :id,
        foreign_key: :course_id,
        class_name: :Enrollment

    has_many :enrolled_students,
        through: :enrollments,
        source: :user
    
    belongs_to :prerequisite,
        primary_key: :id,
        foreign_key: :prereq_id,
        class_name: :Course,
        # some courses will not have prerequisite 
        optional: true 

    belongs_to :instructor,
        primary_key: :id,
        foreign_key: :instructor_id,
        class_name: :User
    
    # Has_one: still works but avoid, because may have more than 1 prereq and instructor in future
    # Note the primary_key and foreign_key using Has_one is different. 

    # # Only one prereq_id 
    # # Self-Join using prereq_id 
    # has_one :prerequisite,
    #     primary_key: :prereq_id,
    #     foreign_key: :id,
    #     class_name: :Course

    # # foreign_key = id of User 
    # has_one :instructor,
    #     primary_key: :instructor_id,
    #     foreign_key: :id,
    #     class_name: :User
end
