class Board
  def initialize(start)
    @board = []
  end

  def make_cells 
    (0..7).each do |x|
      (0..7).each do |y|
        @board.push(Node.new([x, y]))
      end
    end
  end

  def get_neighbors(start)
    array = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
    neighbors = array.map { |pos| start + pos }

    neighbors.select { |neighbor| neighbor >= [0, 0] && neighbor <= [7, 7]}
  end

  def find(array)
    @board.each { |node| return node if node.position == array}
  end
end

class Node
  def initialize(position)
    @position = position
    @neighbors = []
  end

  def position
    [@position[0], position[1]]
  end
end

def knight_moves(start, end)
  knight = Knight.new(start)

end