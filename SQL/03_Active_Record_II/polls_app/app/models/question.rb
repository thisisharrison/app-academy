class Question < ApplicationRecord
    # validates :text, :poll, presence: true
    validates :text, presence: true
    # Rails 5 validates the presence of belongs_to association

    belongs_to :poll, 
        primary_key: :id, 
        foreign_key: :poll_id,
        class_name: :Poll

    has_many :answer_choices,
        primary_key: :id, 
        foreign_key: :question_id,
        class_name: :AnswerChoice,
        dependent: :destroy

    has_many :responses,
        through: :answer_choices,
        source: :responses

    # Not ideal, n + 1 way
    def n_plus_one_results
        answers = self.answer_choices
        
        results = {}
        
        answers.each do |answer|
            results[answer.text] = answer.responses.count
        end

        results
    end

    # Using includes
    def results_2_queries
        answers = self.answer_choices.includes(:responses)
        
        results = {}
        
        answers.each do |answer|
            results[answer.text] = answer.responses.length
        end

        results
    end

    # Using sql, 1 query
    def results

        answers = AnswerChoice.select(:text, 'COUNT(responses.id) AS responses_count')
                        .left_outer_joins(:responses)
                        .group(:id)
                        .having('answer_choices.question_id = ?', id)

        # Using inject
        answers.inject({}) do |results, answer|
            results[answer.text] = answer.responses_count; results
        end
        

        # results = {}
        # answers.each do |answer|
        #     results[answer.text] = answer.responses_count
        # end
        # results
        
    
        # <<-SQL
        # SELECT answer_choices.text, COUNT(responses.id) AS responses_count
        # FROM answer_choices
        # LEFT OUTER JOIN responses
        # ON answer_choices.id = responses.answer_choice_id
        # GROUP BY answer_choices.id
        # HAVING answer_choices.question_id = 1;
        # SQL
    end

end
