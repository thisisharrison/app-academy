require_relative "questions_database"
require_relative "user"
require_relative "reply"
require_relative "question_follow"
require_relative "question_like"

class Question
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Reply.new(datum) }
    end
    
    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT * FROM questions WHERE id = ?
        SQL
        question.length < 0 ? nil : Question.new(question.first)
    end

    def self.find_by_author_id(author_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT * FROM questions WHERE author_id = ?
        SQL
        questions.map { |question| Question.new(question) }
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def self.most_liked(n)
        QuestionLike.most_liked_questions(n)
    end

    attr_reader :id
    attr_accessor :title, :body, :author_id
    
    def initialize(options)
        @id = options['id']        
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def save
        if id.nil?
            QuestionsDatabase.instance.execute(<<-SQL, {title: title, body: body, author_id: author_id})
                INSERT INTO
                    questions (title, body, author_id)
                VALUES
                    (:title, :body, :author_id)
            SQL
            @id = QuestionsDatabase.instance.last_insert_row_id
        else
            QuestionsDatabase.instance.execute(<<-SQL, {id: id, title: self.title, body: self.body, author_id: self.author_id})
                UPDATE
                    questions
                SET
                    title = :title, body = :body, author_id = :author_id
                WHERE
                    id = :id
            SQL
        end
        self
    end

    def author
        User.find_by_id(author_id)
    end

    def replies
        Reply.find_by_question_id(id)
    end

    def followers
        QuestionFollow.followers_for_question_id(id)
    end

    def likers
        QuestionLike.likers_for_question_id(id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(id)
    end

end
