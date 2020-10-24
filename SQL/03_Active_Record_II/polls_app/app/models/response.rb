class Response < ApplicationRecord
    # validates :respondent, :answer_choice, presence: true
    # Rails 5 validates the presence of belongs_to association
    
    # Only run validation if answer choice exists
    validate :not_duplicate_response, unless: -> { answer_choice.nil? }
    validate :respondent_is_not_poll_author, unless: -> { answer_choice.nil? }


    belongs_to :answer_choice,
        primary_key: :id, 
        foreign_key: :answer_choice_id,
        class_name: :AnswerChoice
    
    belongs_to :respondent,
        primary_key: :id,
        foreign_key: :respondent_id,
        class_name: :User
    
    has_one :question,
        through: :answer_choice,
        source: :question

    def sibling_responses
        self.question
            .responses
            .where.not(responses: {id: self.id})
    end

    def respondent_already_answered?
        sibling_responses.exists?(respondent_id: self.respondent_id)
    end

    private

    def not_duplicate_response
        if respondent_already_answered?
            errors[:respondent_id] << "cannot vote twice per question" 
        end
    end

    def respondent_is_not_poll_author
        # Question#answer_choices 
        poll_author_id = Poll.joins(questions: :answer_choices)
                            .where('answer_choices.id = ?', self.answer_choice_id)
                            .pluck('polls.author_id')
                            .first
        
        if poll_author_id == self.respondent_id
            errors[:respondent_id] << "cannot be poll author"
        end
        
        # <<-SQL
        #     SELECT polls.*
        #     FROM polls
        #     JOIN questions ON polls.id = questions.poll_id
        #     JOIN answer_choices ON questions.id = answer_choices.question_id
        #     JOIN responses ON answer_choices.id = responses.answer_choice_id
        #     WHERE responses.respondent_id = polls.author_id;
        # SQL
    end
end
