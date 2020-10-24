class AnswerChoice < ApplicationRecord
    # validates :question, :text, presence: true
    validates :text, presence: true
    # Rails 5 validates the presence of belongs_to association

    belongs_to :question,
        primary_key: :id,
        foreign_key: :question_id,
        class_name: :Question


    has_many :responses,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class_name: :Response,
        dependent: :destroy

end
