require "colorize"
require_relative "cursor"
require_relative "board"

class Display
    attr_reader :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def build_grid
        # inside board, there is instance variable row
        @board.rows.map.with_index do |row, i|
            build_row(row, i)
        end
    end

    def build_row(row, i)
        # row = i
        # col = j
        row.map.with_index do |piece, j|
            color_option = colors_for(i, j)
            piece.to_s.colorize(color_option)
        end
    end

    def colors_for(i, j)
        if cursor.cursor_pos == [i, j] && cursor.selected
            bg = :light_green
        elsif cursor.cursor_pos == [i, j]
            bg = :light_red
        elsif (i + j).odd?
            bg = :light_blue
        else
            bg = :light_grey
        end
        { background: bg }
    end
    
    def render
        system("clear")
        build_grid.each { |row| puts row.join }
    end
end