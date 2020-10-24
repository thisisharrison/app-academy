require_relative "questions_database"
require_relative "user"
require_relative "question"

class QuestionFollow
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map { |datum| QuestionFollow.new(datum) }
    end
    
    def self.find_by_id(id)
        follow = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT * FROM question_follows WHERE id = ?
        SQL
        follow.length < 0 ? nil : QuestionLike.new(follow.first)
    end

    def self.followers_for_question_id(question_id)
        users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT 
                *
            FROM
                users
            WHERE 
                id IN (
                    SELECT 
                        user_id 
                    FROM 
                        question_follows 
                    WHERE 
                        question_id = ?
                    )
        SQL
        users.length < 0 ? nil : users.map { |user| User.new(user) }
    end

    def self.followed_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
            SELECT
                questions.*
            FROM
                question_follows
            JOIN questions ON
                question_follows.question_id = questions.id
            WHERE
                question_follows.user_id = :user_id
        SQL
        questions.map { |question| Question.new(question) }
    end

    def self.most_followed_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, limit: n)
            SELECT
                questions.*
            FROM
                question_follows
            JOIN questions ON
                question_follows.question_id = questions.id
            GROUP BY
                questions.id
            ORDER BY
                COUNT(*) DESC
            LIMIT
                :limit
        SQL
        questions.map { |question| Question.new(question) }
    end

    attr_reader :id
    attr_accessor :question_id, :user_id

    def initialize(options)
        @id = options['id']        
        @question_id = options['question_id']
        @user_id = options['user_id']
    end

end
