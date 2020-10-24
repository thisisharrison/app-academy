require_relative "questions_database"
require_relative "question"
require_relative "reply"
require_relative "question_follow"
require_relative "question_like"
require_relative "model_base"

class User < ModelBase 

    # refactored in ModelBase
    # def self.all
    #     data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    #     data.map { |datum| User.new(datum) }
    # end
    
    # refactored in ModelBase
    # def self.find_by_id(id)
    #     user = QuestionsDatabase.instance.execute(<<-SQL, id)
    #         SELECT * FROM users WHERE id = ?
    #     SQL
    #     user.length < 0 ? nil : User.new(user.first)
    # end

    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT 
                *
            FROM 
                users
            WHERE
                fname = ? AND lname = ?
        SQL
        user.length < 0 ? nil : User.new(user.first)
    end

    attr_reader :id
    attr_accessor :fname, :lname

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    # refactored in ModelBase
    # def save
    #     # raise "#{self} already in db" if id
    #     if id.nil?
    #         QuestionsDatabase.instance.execute(<<-SQL, {fname: fname, lname: lname})
    #             INSERT INTO
    #                 users (fname, lname)
    #             VALUES
    #                 (:fname, :lname)
    #         SQL
    #         # @id instead of self.id, otherwise needs attr_accessor for id
    #         @id = QuestionsDatabase.instance.last_insert_row_id
    #     else
    #         QuestionsDatabase.instance.execute(<<-SQL, {id: id, fname: self.fname, lname: self.lname})
    #             UPDATE
    #                 users
    #             SET
    #                 /* using the new user object created */
    #                 fname = :fname, lname = :lname
    #             WHERE
    #                 id = :id
    #         SQL
    #     end
    #     self
    # end

    def authored_questions
        Question.find_by_author_id(id)
    end

    def authored_replies
        Reply.find_by_user_id(id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(id)
    end

    def average_karma
        # Left outer join on question as question can have null likes
        # count likes.id will count not null values
        avg_karma = QuestionsDatabase.instance.execute(<<-SQL, id: id)
            SELECT
                CAST(COUNT(question_likes.id) AS FLOAT) / 
                COUNT(DISTINCT(questions.id)) AS avg_karma
            FROM
                questions
            LEFT OUTER JOIN
                question_likes
            ON 
                questions.id = question_likes.question_id
            WHERE
                questions.author_id = :id
        SQL

        avg_karma.first['avg_karma'].nil? ? 0.0 : avg_karma.first['avg_karma']
    end

end
