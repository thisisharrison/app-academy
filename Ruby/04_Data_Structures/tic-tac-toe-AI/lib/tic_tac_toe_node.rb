require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board 
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # returns nodes representing all the potential game states one move after the current node
  def children
    children = []    
    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]
        # skip pos unless empty
        next unless @board.empty?(pos)
        dup_board = @board.dup
        # set mark in this position 
        dup_board[pos] = self.next_mover_mark
        # alternate the next mark
        next_mark = (self.next_mover_mark == :x ? :o : :x)
        # shuffle child node to children
        children << TicTacToeNode.new(dup_board, next_mark, pos)
      end
    end
    children
  end

  def losing_node?(evaluator)
    if @board.over?
      # a win not a tie, winner is not nil and winner is not computer mark
      return @board.won? && @board.winner != evaluator
    end

    if self.next_mover_mark == evaluator
      # if it's the evaluator's turn and all children are losing nodes, then they've lost
      self.children.all? { |node| node.losing_node?(evaluator) }
    else
      # if it's not the evaluator's turn and any move is a winning move for the opponent, we have to assume they'll take it
      self.children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      # not a tie, computer is the winner
      return @board.winner == evaluator
    end
    # debugger # # see children evaluates all moves 
    if self.next_mover_mark == evaluator
      # our move next and one of our nodes is winning node
      self.children.any? { |node| node.winning_node?(evaluator) }
    else
      # not computer's move next but all our moves result in us winning
      self.children.all? { |node| node.winning_node?(evaluator) }
    end
  end

end
