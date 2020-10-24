require_relative "questions_database"
require_relative "user"
require_relative "question"

class Reply
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| Reply.new(datum) }
    end
    
    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT * FROM replies WHERE id = ?
        SQL
        reply.length < 0 ? nil : Reply.new(reply.first)
    end

    def self.find_by_user_id(author_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT * FROM replies WHERE author_id = ?
        SQL
        replies.map { |reply| Reply.new(reply) }
    end

    def self.find_by_question_id(question_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT * FROM replies WHERE question_id = ?
        SQL
        replies.map { |reply| Reply.new(reply) }
    end

    attr_reader :id
    attr_accessor :question_id, :parent_reply_id, :author_id, :body

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @author_id = options['author_id']
        @body = options['body']
    end

    def attr
        {question_id: question_id, parent_reply_id: parent_reply_id, author_id: author_id, body: body}
    end

    def save
        if id.nil?
            QuestionsDatabase.instance.execute(<<-SQL, attr)
                INSERT INTO
                    replies (question_id, parent_reply_id, author_id, body)
                VALUES
                    (:question_id, :parent_reply_id, :author_id, :body)
            SQL
            @id = QuestionsDatabase.instance.last_insert_row_id
        else
            QuestionsDatabase.instance.execute(<<-SQL, attr.merge({id: self.id}))
                UPDATE
                    replies
                SET
                    question_id = :question_id, parent_reply_id = :parent_reply_id, author_id = :author_id, body = :body
                WHERE
                    id = :id
            SQL
        end
        self
    end

    def author
        User.find_by_id(author_id)
    end

    def question
        Question.find_by_id(question_id)
    end

    def parent_reply
        reply = QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id)
            SELECT * FROM replies WHERE id = ?
        SQL
        reply.nil? ? nil : Reply.new(reply.first)
    end

    def child_replies
        replies = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT * FROM replies WHERE parent_reply_id = ?
        SQL
        replies.nil? ? nil : replies.map { |reply| Reply.new(reply) }
    end

end
