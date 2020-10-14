require "singleton"

module Slideable

    def moves
        res = []
        dirs = self.move_dirs
        #[1,0]
        dirs.each do |dir|
            x, y = dir
            res.concat(grow_unblocked_moves_in_dir(x, y))
        end
        return res
    end

    # dx = 1, dy = 0
    # Want to add dx and dy into position
    # Want to increment dx or dy by one each iteration
    # Check piece at incremented position
    # If NullPiece include that position and keep looking in same direction
    # If new position has a piece of a different color, include position but stop iterating
    # If new position has same color piece, do not include/stop iterating

    # x = 1 y = 0

    def horizontal
        return HORIZONTAL
    end

    def diagonals
        return DIAGONALS
    end
    
    private
    HORIZONTAL = [[1,0],[-1,0],[0,1],[0,-1]]
    DIAGONALS = [[1,1], [-1,-1], [1,-1],[-1,1]]
    
    def grow_unblocked_moves_in_dir(dx, dy)
        res = []
        old_row, old_col = self.pos
        new_row, new_col = old_row + dx, old_col + dy
        checker = true
        while checker == true && (new_col.between?(0,7)) && (new_row.between?(0,7))
            next_pos = self.board[new_row][new_col]
            if next_pos.is_a?(NullPiece)
                res << [new_row, new_col]
                new_row, new_col = new_row + dx, new_col + dy               
            elsif next_pos.symbol != self.symbol
                res << [new_row, new_col]
                checker = false
            else
                checker = false
            end
        end 
        res
    end   
end

module Stepable    
    def moves
        res = []

    end
end

class Piece

    attr_reader :board, :pos

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def symbol
        @color
    end

    def pos=(val)
        @pos = val
    end

    # def move_into_check?(end_pos)
    #     if @board[end_pos] != NullPiece.instance && @board[end_pos].symbol == self.symbol
    #         return false
    #     else
    #         true
    #     end
    # end

    # def valid_moves

    # end

end

# Slideable Pieces
class Rook < Piece
    include Slideable
    
    def initialize(color, board, pos)
        super
    end

    def move_dirs
        return self.horizontal
    end

end


class Bishop < Piece
    include Slideable
    
    def initialize(color, board, pos)
        super
    end

    def move_dirs
        return self.diagonals
    end

end


class Queen < Piece
    include Slideable
    
    def initialize(color, board, pos)
        super
    end

    def move_dirs
        return self.horizontal + self.diagonals
    end
end

# Stepable Pieces

class Knight < Piece
    include Stepable
    KNIGHT_MOVES = [[-2, -1],[-1,-2],[1,-2],[2,-1],[1,2],[2,1],[-1,2],[-2,1]]
    
    def initialize(color, board, pos)
        super
    end

    def move_diffs
        return KNIGHT_MOVES
    end
end

class King < Piece
    include Stepable
    KING_MOVES = [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,-1],[1,-1],[-1,1]]
    
    def initialize(color, board, pos)
        super
    end

    def move_diffs
        return KING_MOVES
    end
end

# Pawn Piece

class Pawn < Piece
    
    def initialize(color, board, pos)
        super
    end

    def move_dirs
        
    end
end

# NullPiece 

class NullPiece < Piece
    include Singleton
    def initialize
    end
end