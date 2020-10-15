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
        diffs = self.move_diffs
        
        diffs.each do |diff|
            old_pos = self.pos
            new_pos = [ old_pos[0] + diff[0], old_pos[1] + diff[1] ]

            if ok?(new_pos)
                res << new_pos
            end
        end
        res
    end

    def ok?(new_pos)
        x, y = new_pos
        next_pos = self.board[x][y]
        if x.between?(0,7) && y.between?(0,7) 
            if next_pos.symbol == self.symbol
                return false
            else
                return true
            end
        else
            return false
        end
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
    
    # PAWN_DIRECTIONS = [[1,0], [-1,0]]

    def initialize(color, board, pos)
        super
    end

    def symbol
        @color
    end

    def at_start_row?
        if @pos[0] == 6 && symbol == :white
            return true
        elsif @pos[0] == 1 && symbol == :black
            return true
        else
            return false
        end
    end

    def forward_dir
        if self.symbol == :black
            return 1
        else
            return -1
        end
    end

    def forward_steps
        res = []
        old_pos = self.pos

        if at_start_row? && forward_dir == 1
            dirs = [[1,0], [2,0]]
            res += [old_pos[0] + ] 
        elsif at_start_row? && forward_dir == -1
            return [[-1,0], [-2,0]]
        elsif forward_dir == 1
            return [[1,0]]
        else
            return [[-1,0]]
        end
    end

    def side_attacks
        res = []
        black = [[1,-1], [1,1]]
        white = [[-1,1], [-1,-1]]

        x, y = self.pos
        next_pos = self.board

        if forward_dir == 1
            black.each do |dir|
                new_pos = [x + dir[0], y + dir[1]]
                i, j = new_pos
                next_pos = self.board[i][j]
                if next_pos.symbol != self.symbol && next_pos.symbol != :empty
                    res << [i, j]
                end
            end
        else
            white.each do |dir|
                new_pos = [x + dir[0], y + dir[1]]
                i, j = new_pos
                next_pos = self.board[i][j]
                if next_pos.symbol != self.symbol && next_pos.symbol != :empty
                    res << [i, j]
                end
            end
        end
        res
    end

    def move_dirs
        res = []
        res.concat(forward_steps)
        res.concat(side_attacks)
        res
    end

end

# NullPiece 

class NullPiece < Piece
    include Singleton
    def initialize
        @color = :empty
    end

    def symbol
        @color
    end
end