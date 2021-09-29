#Noughts and Crosses

$grid = [["-", "-", "-"],
        ["-", "-", "-"],
        ["-", "-", "-"]]

$y_mapping = {1 => 2, 2=> 1, 3 => 0}
$y_mapping.default = 100

def flip_coin
  puts "Let's flip a coin to decide!"
  while true
    puts "Heads or tails, put in H or T:"
    coin_choice = gets.chomp
    if coin_choice == "H"
      coin_choice = 1
      break
    elsif coin_choice == "T"
      coin_choice = 0
      break
    else
      puts "Invalid choice, try again."
    end
  end
  puts "Ok let's flip and see!"
  coin_outcome = rand(0..1)
  if coin_outcome == 1
    puts "It's heads."
  else
    puts "It's tails."
  end
  if coin_choice == coin_outcome
    puts "You win so you go first!"
    $winner = true
  else
    puts "I'm afraid you lose, you go second!"
    $winner = false
  end
end

def valid_move? (x, y)
  if !(x.between?(0, 2)) || !(y.between?(0, 2))
    return false
  elsif $grid[y][x] == "X" || $grid[y][x] == "O"
    return false
  else
    return true
  end
end

def check_winner(str)
  for i in 0..2
    #Vertical win
    if $grid[0][i] == str && $grid[1][i] == str && $grid[2][i] == str
      puts "#{str} won!"
      exit
    #Horizontal win
    elsif $grid[i][0] == str && $grid[i][1] == str && $grid[i][2] ==str
      puts "#{str} won!"
      exit
    #Diagonal win
    elsif ($grid[0][0] == str && $grid[1][1] == str && $grid[2][2] ==str) || ($grid[2][0] == str && $grid[1][1] == str && $grid[0][2] == str)
      puts "#{str} won!"
      exit
    elsif $grid.all? {|array| array.all? {|points| points == "X" || points == "O"}}
      puts "We have a draw!"
      exit
    end
  end
end

def noughts_choice
  if $opponent_choice == "pc"
    while true
      x_input = rand(0..2)
      y_input = rand(0..2)
      if valid_move?(x_input, y_input)
        $grid[y_input][x_input] = "O"
        break
      else
        "Invalid move"
      end
    end
  else
    while true
      puts "Enter it as co-ordinates in the style of x,y"
      puts "Firstly x:"
      x_input = gets.chomp.to_i - 1
      puts "And now y:"
      y_input = gets.chomp.to_i
      y_input = $y_mapping[y_input]
      if valid_move?(x_input, y_input)
        $grid[y_input][x_input] = "O"
        break
      else
        "Invalid move"
      end
    end
  end
end

while true
  puts "Are we playing locally or against the computer?"
  puts "[Local], [PC]"
  $opponent_choice = gets.chomp.downcase
  if $opponent_choice == "local"
    puts "Local it is!"
    break
  elsif $opponent_choice == "pc"
    puts "Againts the PC, let's do it!"
    break
  else
    puts "Invalid choice, try again please."
  end
end

puts "#{$grid[0]}\n#{$grid[1]}\n#{$grid[2]}"

puts "Let's decide who goes first, that's only fair after all..."
if $opponent_choice == "pc"
  puts "You are up against the PC, so you will be Crosses."
else
  puts "Decide who is Noughts and who is Crosses"
  puts "Crosses decides on heads or tails"
end
flip_coin

if $winner == false
  noughts_choice
  puts "#{$grid[0]}\n#{$grid[1]}\n#{$grid[2]}"
end

while true
  puts "Crosses turn, where do you want to go?"
  puts "Enter it as co-ordinates in the style of x,y"
  puts "Firstly x:"
  x = gets.chomp.to_i - 1
  puts "And now y:"
  y = gets.chomp.to_i
  y = $y_mapping[y]
  if valid_move?(x, y)
    $grid[y][x] = "X"
    puts "#{$grid[0]}\n#{$grid[1]}\n#{$grid[2]}"
    check_winner("X")
    puts "Ok now it is Noughts' turn"
    noughts_choice
    puts "#{$grid[0]}\n#{$grid[1]}\n#{$grid[2]}"
    check_winner("O")
  else
    puts "Invalid move. Try again."
  end
end
