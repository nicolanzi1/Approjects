require './board.rb'
require './human_player.rb'
require './computer_player.rb'

class Game
    def initialize(n, players)
        @players = players.map do |mark, is_computer|
            is_computer ? ComputerPlayer.new(mark) : HumanPlayer.new(mark)
        end
        @board = Board.new(n)
        @current_player = @players.first
    end

    def switch_turn
        @current_player = @players.rotate!.first
    end

    def play
        while @board.empty_positions?
            @board.print
            choices = @board.legal_positions
            pos = @current_player.get_position(choices)
            @board.place_mark(pos, @current_player.mark)
            if @board.win?(@current_player.mark)
                puts 'Game Over'
                puts "Flawless victory, Player " + @current_player.mark.to_s + " wins!!!"
                return
            else
                switch_turn
            end
        end

        puts 'Game Over'
        puts 'Unbelievable, we have a tie :O'
    end
end