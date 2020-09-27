require_relative 'pieces'
require "byebug"

class Board 
    attr_reader :rows

    def initialize(fill_board = true)
        @sentinel = NullPiece.instance
        make_starting_grid(fill_board)
    end

    def [](pos)
        x, y = pos
        @rows[x][y]
    end

    def []=(pos, value)
        x, y = pos
        @rows[x][y] = value
    end

    def add_piece(piece, pos)
        self[pos] = piece
    end

    def move_piece(color, start_pos, end_pos)
        raise "start_pos can't be empty" if empty?(start_pos)
        
        piece = self[start_pos]
        
        raise "not your turn" if piece.color != color
        raise "end_pos not valid" if !valid_pos?(end_pos)
        raise "piece cannot move like that" if !piece.moves.include?(end_pos)
        raise "you cannot move into check" if !piece.valid_moves.include?(end_pos)

        move_piece!(start_pos, end_pos)
    end

    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]
        self[end_pos] = piece
        self[start_pos] = sentinel
        piece.pos = end_pos
    end

    def empty?(pos)
        self[pos].empty?
    end

    def valid_pos?(pos)
        pos.all? { |coor| coor.between?(0, 7) }
    end

    def pieces 
        # get all the pieces 
        @rows.flatten.reject(&:empty?)
    end

    def find_king(color)
        # using the pieces method
        king_pos = pieces.find { |p| p.color == color && p.is_a?(King) }
        # return object
        king_pos || (raise "king not found")
    end

    def in_check?(color)
        # use the returned object to get the pos
        king_pos = find_king(color).pos
        # the whole board, any opponent's pieces' moves include king's pos
        pieces.any? do |p|
            p.color != color && p.moves.include?(king_pos)
        end
    end

    def checkmate?(color)
        return false unless in_check?(color)
        # none of color's pieces have any #valid_moves
        # filters out the #moves of a Piece that would leave the player in check
        pieces.select { |p| p.color == color }.all? do |piece|
            piece.valid_moves.empty?
        end
    end
    
    # create a duplicate of the board to see if in-check
    def dup
        new_board = Board.new(false)
        # the existing pieces in the real board, duplicate in this new_board
        pieces.each do |piece|
            # .class to get piece type
            piece.class.new(piece.color, new_board, piece.pos)
        end
        new_board
    end
    

    private 

    attr_reader :sentinel

    def make_starting_grid(fill_board)
        @rows = Array.new(8) {Array.new(8, sentinel)}
        # only recreate starting board if it's new game, and not a dup
        return unless fill_board
        %i(white black).each do |color|
            fill_back_row(color)
            fill_pawn_row(color)
        end
    end

    def fill_back_row(color)
        back_pieces = [
            Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
        ]
        
        # black and white reversed, white is "bottom board", thus 7
        # i = row
        # j = col
        i = color == :white ? 7 : 0 
        back_pieces.each_with_index do |piece, j|
            # Calling on init of Rook, Knight etc 
            piece.new(color, self, [i, j])
        end
    end

    def fill_pawn_row(color)
        # black and white reversed, white is "bottom board", thus 6, 1 "above" backrow 
        # i = row
        # j = col
        i = color == :white ? 6 : 1
        8.times { |j| Pawn.new(color, self, [i, j]) }
    end
end
