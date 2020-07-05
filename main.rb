# module Tic Tac Toe game which includes classes: Player & Board
# frozen_string_literal: true
module Game
  # class Player for initialization of player objects
    class Player

        attr_accessor :name, :marker, :current_player, :player_array
        def initialize(name, marker)
            @name = name
            @marker = marker
            @current_player = true
            @player_array = []
        end
    end

# class Board for initialization of board object
    class Board
        attr_accessor :board_array
        def initialize
            @board_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        end

        def display_board
            puts "#{@board_array[0]} | #{@board_array[1]} | #{@board_array[2]}"
            puts '---------'
            puts "#{@board_array[3]} | #{@board_array[4]} | #{@board_array[5]}"
            puts '---------'
            puts "#{@board_array[6]} | #{@board_array[7]} | #{@board_array[8]}"
        end

    def update_game_board(current_player)
      selection = gets.chomp
      current_player.player_array.push(selection.to_i)
      @board_array[selection.to_i - 1] = current_player.marker
      display_board
    end

    def board_full?
      counter = 0
      numbers = (0..9)
      @board_array.each do |element|
        if numbers.include?(element) == true
            next
        else
          counter += 1
        end
      end
      'Board full' if counter == 9
    end

    def get_player_one
      puts "What is Player one's name?"
      player_one_name = gets.chomp
      player_one = Player.new(player_one_name, 'x')
      puts "Greetings #{player_one_name.capitalize}! You are #{player_one.marker}'s."
      player_one
    end

    def get_player_two
      puts "What is Player two's name?"
      player_two_name = gets.chomp
      player_two = Player.new(player_two_name, 'o')
      puts "Greetings #{player_two_name.capitalize}! You are #{player_two.marker}'s."
      player_two
    end

    def win_condition(player_one, player_two)
      winning_combinations = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 5, 9], [3, 5, 7], [1, 4, 7], [2, 5, 8], [3, 6, 9]]
      winning_combinations.each do |set|
          if player_one.player_array.sort == set
            break player_one
          elsif player_two.player_array.sort == set
            break player_two 
          elsif board_full? == 'Board full'
            break 'tie' 
          else
            nil
          end
        end
    end
end
  def self.determine_current_player(first_player, second_player)
    if first_player.current_player == true
      first_player.current_player = false
      second_player.current_player = true
      first_player
    elsif second_player.current_player == true
      second_player.current_player = false
      first_player.current_player = true
      second_player
    end
  end

  def self.run_game
    puts 'Welcome to command-line tic-tac-toe with Ruby!'
    new_game = Board.new
    player_one = new_game.get_player_one
    player_two = new_game.get_player_two
    current_player = determine_current_player(player_one, player_two)
    puts "#{current_player.name.capitalize} please select a number: "
    new_game.display_board
    new_game.update_game_board(current_player)
    while new_game.win_condition(player_one, player_two) != player_one \
        && new_game.win_condition(player_one, player_two) != player_two \
        && new_game.win_condition(player_one, player_two) != "tie"
      current_player = determine_current_player(player_one, player_two)
      puts "#{current_player.name.capitalize} please select a number: "
      new_game.update_game_board(current_player)
      new_game.win_condition(player_one, player_two)
    end
    if new_game.win_condition(player_one, player_two) == 'tie'
      puts "It's a tie!"
    else
      winner = new_game.win_condition(player_one, player_two)
      puts "#{winner.name.capitalize} is the winner!"
    end
  end
end

Game.run_game()
