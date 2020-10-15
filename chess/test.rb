#   0 1 2 3 4 5 6 7
# 0 x _ x x x x x x 
# 1 x x x x x _ x x 
# 2 _ _ _ _ _ _ _ _ 
# 3 _ _ _ _ _ x _ _ 
# 4 _ _ _ _ _ _ _ _ 
# 5 _ _ _ _ _ _ x _ 
# 6 o o o o o o o o 
# 7 o o o o o o o o 

# [4,1] [4,2] [4,4] [4,5] [4,6] [3,3] [2,3] [1,3] [5,3]
          x      x                x                  x           

# [2,3] [2,5] [4,5] [4,3] [5,6] [6,7]


# [1,2] [2,2] [3,0] [3,1] [3,3] [3,4] [4,2] [5,2] [2,1] [1,0] [4,1] [5,0] [2,3] [1,4]

load "board.rb"
b = Board.new
b.move_piece([7,0], [4,3])
# puts "White rook moves to 4,3"
b[[4,3]].moves
b.move_piece([0,0], [4,6])
# puts "Black rook moves to 4,6"
b[[4,6]].moves
b.move_piece([6,0], [4,0])
# puts "White pawn moves to 4,0"
b[[4,0]].moves
b.move_piece([0,2], [3,4])
# puts "Black bishop moves to 3,4"
b[[3,4]].moves
b.move_piece([7,3], [3,2])
# puts "White queen moves to 3,2"
b[[3,2]].moves