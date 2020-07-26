class Item 

    def self.valid_date?(str)
        arr = str.split("-").map(&:to_i)
        year, month, day = arr
        return false if arr.length != 3
        return false if !(0..12).include?(month)
        return false if !(0..31).include?(day)
        true
    end

    attr_accessor :title, :description
    attr_reader :deadline, :done
    
    def initialize(title, deadline, description)
        raise "Incorrect Date Format" if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    def deadline=(new_deadline)
        raise "Incorrect Date Format" if !Item.valid_date?(new_deadline)
        @deadline = new_deadline
    end

    def toggle
        @done = !@done
    end
end
