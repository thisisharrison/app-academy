require "byebug"

class Maze
    attr_reader :map, :start, :end

    DIRECTION = [[0,1],[0,-1],[1,0],[-1,0]]
    # [E, W, S, N]

    def initialize(filename)
        @map = load_map(filename)
        @start = find_start
        @end = find_end
    end


    def find_start
        find_char('S')
    end

    def find_end
        find_char('E')
    end

    def find_char(char)
        @map.each_with_index do |row, r|
            row.each_with_index do |col, c|
                return [r, c] if self[[r, c]] == char
            end
        end
    end

    def is_wall?(pos)
        self[pos] == "*"
    end

    def in_maze?(pos)
        row, col = pos
        return false if row < 0 || col < 0
        row <= @map.length - 1 && col <= @map.first.length - 1
    end

    def is_SE?(pos)
        self[pos] != "S" && self[pos] != "E" 
    end

    def find_neighbour(pos)
        neighbours = []
        DIRECTION.each do |row, col|
            new_pos = [pos[0] + row, pos[1] + col]
            neighbours << new_pos if in_maze?(new_pos) && !(is_wall?(new_pos))
        end
        neighbours
    end

    def win?(pos)
        self[pos] == "E"
    end

    def [](pos)
        row, col = pos
        @map[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @map[row][col] = value
    end

    def load_map(filename)
        map = []
        File.open(filename).each_line do |line|
            map << line.split(//)
        end
        map
    end

    def render
        @map.each do |row|
            puts row.join("")
        end
    end
    

    def find_path(start_pos)
        return [start_pos] if win?(start_pos)
        neighbours = find_neighbour(start_pos)
        len = neighbours.length
        
        while !neighbours.include?(@end)
            neighbours.last(len).each do |pos|
                len = 0
                new_n = find_neighbour(pos)
                len = new_n.length
                neighbours = [*neighbours, *new_n].uniq
            end 
        end
        p "Filling out all possible coor..."
        p neighbours
        p "Refining to valid paths..."
        p refine(neighbours)
    end

    def refine(paths)
        refined = []

        while refined.last != @end
            paths.each do |coor|
                if refined.empty? || is_valid?(refined.last, coor) && !refined.include?(coor)
                    refined << coor
                end
            end
        end
        refined
    end

    def is_valid?(pos_1, pos_2)
        x_1, y_1 = pos_1
        x_2, y_2 = pos_2
        DIRECTION.include?([x_1 - x_2, y_1 - y_2]) 
    end
    
    # fill out the map with available pos
    def run    
        all = find_path(@start)
        all.each do |pos|
            self[pos] = 'X' if is_SE?(pos)
            self.render
            sleep(0.1)
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    m = Maze.new('./maze1.txt')
    m.render
    m.run
end