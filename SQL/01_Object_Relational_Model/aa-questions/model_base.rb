# Shared by all classes 
require 'active_support/inflector'
require_relative "questions_database"

class ModelBase
    def self.table
        # takes class name to string and tableize
        self.to_s.tableize
    end

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM #{table}")
        data.map { |datum| self.new(datum) }
    end

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
            SELECT 
                * 
            FROM 
                /* calls self.table */
                #{table}
            WHERE 
                id = :id
        SQL
        data.nil? ? nil : self.new(data)
    end

    def self.find_by(params)
        # params format, eg. lname: "Lau"
        self.where(params)
    end

    def self.where(params)
        # Hash if given specific column keys
        if params.is_a?(Hash)
            where_line = params.keys.map { |key| "#{key} = ?" }.join(" AND ")
            values = params.values
        else
            # params is given in a string, values are in the string
            where_line = params
            values = []
        end

        data = QuestionsDatabase.instance.execute(<<-SQL, *values)
            SELECT 
                *
            FROM
                #{self.table}
            WHERE
                #{where_line}
        SQL

        data.map{ |datum| self.new(datum) }
    end

    def attr
        # using an instance object
        # instance_variables returns [:@id, :@fname, :@lname]
        # map into tuples
        # hash the array of tuples
        Hash[self.instance_variables.map do |name|
            # name = :@fname for example
            # [1..-1] to trim @
            # instance_variable_get(:@fname) = attr_reader
            [name.to_s[1..-1], instance_variable_get(name)]
        end]
    end

    def save 
        self.id.nil? ? create : update
    end

    def create
        # take out id from attr
        inst_attrs = attr
        inst_attrs.delete("id")
        # col names of remaining attributes, join with comma
        col_names = inst_attrs.keys.join(", ")
        # for values line in SQL
        question_marks = (["?"] * inst_attrs.count).join(", ")
        # actual values
        values = inst_attrs.values 

        QuestionsDatabase.instance.execute(<<-SQL, *values)
            INSERT INTO
                #{self.class.table} (#{col_names})
            VALUES
                (#{question_marks})
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end
    
    def update
        # take out id from attr
        inst_attrs = attr
        inst_attrs.delete("id")
        # set line 
        set_line = inst_attrs.keys.map{ |name| "#{name} = ?"}.join(", ")
        # actual values
        values = inst_attrs.values 

        QuestionsDatabase.instance.execute(<<-SQL, *values, id)
            UPDATE
                #{self.class.table}
            SET
                #{set_line}
            WHERE
                id = ?
        SQL
        self
    end

end
