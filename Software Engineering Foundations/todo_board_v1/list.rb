require './item.rb'

class List 
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description='')
        return false if !Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description)
        true
    end

    def size
        @items.length
    end

    def valid_index?(index)
        (0...self.size).include?(index)
    end

    def swap(index_1, index_2)
        return false if !valid_index?(index_1) || !valid_index?(index_2)
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
        return nil if !valid_index?(index)
        @items[index]
    end

    def priority
        self[0]
    end

    def print_full_item(index)
        return if self[index].nil?
        puts "#{self[index].title} | #{self[index].description} | #{self[index].deadline}"
    end

    def print
        puts "------"
        puts @label
        @items.each_with_index { |item, i| print_full_item(i) }
        puts "------"
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount=1)
        return if !valid_index?(index)
        while index != 0 && amount > 0
            swap(index, index - 1)
            index -= 1
            amount -= 1
        end
        true
    end

    def down(index, amount=1)
        return if !valid_index?(index)
        while amount > 0 && index != size - 1
            swap(index, index + 1)
            index += 1
            amount -= 1
        end
        true
    end

    def sort_by_date!
        @items.sort_by!{|item| item.deadline }
    end
end