#a class called board containing all methods is created
class Board
# You should put here the given boards templates
  #It initializes variables defining the range containing the alphabet
  #and how the board will handle format
  def initialize(board_string)
    @mix = board_string.gsub(/[X]/){|x| ("A".."Z").to_a.sample}
    @board =  @mix.scan(/.{5}/).map!{|row| row.split("")}
  end

  #which it is defined in each element
  def to_s(board=nil)
    if board.nil?
     board = @board
    end
    board.each do |row|
    row.each do |element|
      print "  #{element}  "
      end
      puts
    end 
    " "
  end
  #the condition in which you can read the words that are read diagonally
  def check_board(word)
    new_board = []
    @board.map{|row| new_board << row.dup}
    diagonal = convert_diagonals(new_board)
    
    if check_rows(@board, word) || check_rows(@board.transpose, word) || check_rows(diagonal, word) || check_rows(diagonal.transpose, word) 
      true
    else
      false
    end
  end
  #it is assessed that the words are uppercase in general to keep order
  def check_rows(board, word)
    board.transpose.each do |row|
      return true if word_in_array(row,word.upcase)  
      return true if word_in_array(row.join.reverse.split(""),word.upcase)
    end
    false
  end
  #the method is defined to accommodate some plabras diagonally
  def convert_diagonals(board_diagonal)
    board_diagonal.each_with_index do |row, index|
      index.times do  
        row.unshift(" ")
      end
      (board_diagonal.length-index).times do 
        row.push(" ")
      end
    end
    board_diagonal
  end
  #the method wherein assess whether the word is found in any of the spaces 
  #and gives it to true or false case is defined as
  def word_in_array(array,word)
    array.join.include?(word) ? true : false
  end
end
#Driver code...
words = ["POEMA", "CANCION", "RONDAS", "RIMAS", "SAMIR"]  
board = Board.new("POEMAXCXXXXAXXSXNXAAXCMXDXIXXNROXXOXNXXR")
puts board
words.each do |word|
 p board.check_board(word)
end
words = ["MANGO", "SANDIA", "MELON", "PLATANO"]
board = Board.new("XXXXPXXXXLXAMXAXIEXTXDLXAXNOXNMANGOXSXXX")
puts board
words.each do |word|
  p board.check_board(word)
end

words = ["ROJO", "VERDE", "AZUL", "NEGRO"]
board = Board.new("OJORXXXXXXXEXXOXDXRXXRGLXXEXUXNVXZXXXXAX")
puts board
words.each do |word|
  p board.check_board(word)
end