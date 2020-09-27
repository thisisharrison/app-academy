require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    
    # possible positions
    poss_pos = node.children 
    
    # find winning nodes, find the first one
    win_node = poss_pos.find do |child| 
      child.winning_node?(mark)
    end
    
    # return we found a winning pos
    return win_node.prev_move_pos if win_node
    
    # win_node is nil because no wining pos, pick one that's not a loser
    alt_node = poss_pos.find do |child|
      !child.losing_node?(mark)
    end

    return alt_node.prev_move_pos if alt_node

    raise "Bot: I'm going to lose"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Harry")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
