require_relative 'piece'
require 'singleton'

class NullPiece < Piece
    attr_reader :symbol, :color
    
    include Singleton
    
    def initialize 
        @symbol = " "
        @color = :none
    end

    def empty?
        true
    end

    def moves
        []
    end
end
