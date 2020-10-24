require_relative "questions_database"
require_relative "user"
require_relative "question"

class QuestionLike
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map { |datum| QuestionLike.new(datum) }
    end
    
    def self.find_by_id(id)
        like = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT * FROM question_likes WHERE id = ?
        SQL
        like.length < 0 ? nil : QuestionLike.new(like.first)
    end

    def self.likers_for_question_id(question_id)
        likers = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
            SELECT
                users.*
            FROM
                question_likes
            JOIN 
                users 
            ON 
                question_likes.user_id = users.id
            WHERE 
                question_likes.question_id = :question_id
        SQL
        likers.map { |user| User.new(user) }
    end

    def self.num_likes_for_question_id(question_id)
        count = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
            SELECT
                COUNT(*) AS result
            FROM
                question_likes
            WHERE
                question_id = :question_id
        SQL
        count.first['result']
    end

    def self.liked_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
            SELECT
                questions.*
            FROM
                question_follows
            JOIN
                questions
            ON 
                question_follows.question_id = questions.id
            WHERE
                question_follows.user_id = :user_id
        SQL
        questions.map { |question| Question.new(question) }
    end

    def self.most_liked_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, limit: n)
            SELECT
                questions.*
            FROM
                question_likes
            JOIN
                questions
            ON 
                question_likes.question_id = questions.id
            GROUP BY
                questions.id
            ORDER BY
                COUNT(*) DESC
            LIMIT 
                :limit
        SQL
        questions.map { |question| Question.new(question) }
    end

    def self.num_likes_for_user_id(user_id)
        
    end

    attr_reader :id
    attr_accessor :user_id, :question_id

    def initialize(options)
        @id = options['id']        
        @user_id = options['user_id']
        @question_id = options['question_id']
    end
end
