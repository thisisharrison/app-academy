class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :authored_polls,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :Poll

    has_many :responses,
        primary_key: :id,
        foreign_key: :respondent_id,
        class_name: :Response

    # return polls where user has answered all the questions
    def completed_polls_sql
        # move WHERE in LEFT OUTER JOIN to include responses user didn't make. 
        # only joining on responses user made with LEFT OUTER JOIN to count questions haven't answered
        Poll.find_by_sql(<<-SQL)
            SELECT polls.*
            FROM polls
            JOIN questions ON polls.id = questions.poll_id
            JOIN answer_choices ON questions.id = answer_choices.question_id
            LEFT OUTER JOIN (
                SELECT *
                FROM responses
                WHERE respondent_id = #{self.id}
            ) AS responses ON answer_choices.id = responses.answer_choice_id
            GROUP BY polls.id
            HAVING COUNT(DISTINCT questions.id) = COUNT(responses.*);
        SQL
    end

    def incompleted_polls_sql
        # number of questions outweighs responses given
        Poll.find_by_sql(<<-SQL)
            SELECT polls.*
            FROM polls
            JOIN questions ON polls.id = questions.poll_id
            JOIN answer_choices ON questions.id = answer_choices.question_id
            LEFT OUTER JOIN (
                SELECT *
                FROM responses
                WHERE respondent_id = #{self.id}
            ) AS responses ON answer_choices.id = responses.answer_choice_id
            GROUP BY polls.id
            HAVING COUNT(DISTINCT questions.id) > COUNT(responses.*);
        SQL
    end

end
