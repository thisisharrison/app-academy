class Enrollment < ApplicationRecord

    # has foreign key pointing to User and Course table
    # record holds a reference pointing to the associated record
    # so we use belongs_to

    belongs_to :user,
        primary_key: :id,
        foreign_key: :student_id,
        class_name: :User

    belongs_to :course,
        primary_key: :id,
        foreign_key: :course_id,
        class_name: :Course

end
