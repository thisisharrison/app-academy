require './list.rb'

class TodoBoard
    def initialize
        @lists = {}
    end

    def get_command
        print "\nEnter a command: "

        cmd, target, *args = gets.chomp.split(" ")

        case cmd
        when 'mklist'
            @lists[target] = List.new(target)
        when 'ls'
            @lists.keys.each {|label| puts label}
        when 'showall'
            @lists.each_value(&:print)
        when 'mktodo'
            @lists[target].add_item(*args) 
        when 'toggle'
            @lists[target].toggle_item(args[0].to_i) 
        when 'rm'
            @lists[target].remove_item(args[0].to_i) 
        when 'purge'
            @lists[target].purge
        when 'up'
            @lists[target].up(*args.map(&:to_i))
        when 'down'
            @lists[target].down(*args.map(&:to_i))
        when 'swap'
            @lists[target].swap(*args.map(&:to_i))
        when 'sort'
            @lists[target].sort_by_date!
        when 'priority'
            @lists[target].print_priority
        when 'print'
            if args.empty?
                @lists[target].print
            else
                @lists[target].print_full_item(args[0].to_i)
            end
        when 'quit'
            return false
        else
            puts 'Command not recognized'
        end
        true
    end

    def run
        while true
            return if !get_command
        end
    end
end

t = TodoBoard.new()
t.run