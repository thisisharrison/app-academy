require "sqlite3"
require "singleton"

class QuestionsDatabase < SQLite3::Database
    # class can then be available through QuestionsDatabase.instance method
    include Singleton

    def initialize
        super("questions.db")
        self.type_translation = true
        self.results_as_hash = true
    end

end