require_relative "piece"

class Board

    attr_accessor :board


    # Need to refactor for individual pieces
    def self.populate(board)
        (0..7).each do |row|
            (0..7).each do |col|
                if row == 0 
                    if col == 0 || col == 7 
                        board[row][col] = Rook.new(:black, board, [row, col])
                    elsif col == 1 || col == 6
                        board[row][col] = Knight.new(:black, board, [row, col])
                    elsif col == 2 || col == 5
                        board[row][col] = Bishop.new(:black, board, [row, col])
                    elsif col == 3
                        board[row][col] = King.new(:black, board, [row, col])
                    else
                        board[row][col] = Queen.new(:black, board, [row, col])
                    end
                elsif row == 1
                    board[row][col] = Pawn.new(:black, board, [row, col])
                elsif row == 6
                    board[row][col] = Pawn.new(:white, board, [row, col])
                elsif row == 7
                    if col == 0 || col == 7 
                        board[row][col] = Rook.new(:white, board, [row, col])
                    elsif col == 1 || col == 6
                        board[row][col] = Knight.new(:white, board, [row, col])
                    elsif col == 2 || col == 5
                        board[row][col] = Bishop.new(:white, board, [row, col])
                    elsif col == 4
                        board[row][col] = King.new(:white, board, [row, col])
                    else
                        board[row][col] = Queen.new(:white, board, [row, col])
                    end
                else
                    board[row][col] = NullPiece.instance
                end
            end
        end
    end

    def initialize
        @board = Array.new(8) {Array.new(8)}
        Board.populate(@board)
    end

    def [](pos)
        x, y = pos
        @board[x][y]
    end

    def []=(pos, value)
        x, y = pos
        @board[x][y] = value
    end

    def move_piece(start_pos, end_pos)
        x, y = start_pos
        i, j = end_pos

        if @board[x][y] == NullPiece.instance
            raise StandardError 
        elsif i < 0 || i > 7 || j < 0 || j > 7
            raise StandardError
        else
            @board[i][j] = @board[x][y]
            @board[i][j].pos = [i,j]
            @board[x][y] = NullPiece.instance
        end

        rescue StandardError => err
            puts "This is wrong position"
    end

    
end
