class Board
  def initialize
    @board = []
  end

  def make_cells 
    for x in (0..7)
      for y in (0..7)
        @board.push(Node.new([x, y]))
      end
    end

    @board
  end

  def get_neighbors(node)
    position = node.position
    array = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]

    array = array.map { |elem| elem.map.with_index { |coordinate, i| coordinate + position[i]} }
    
    valid = array.select do |elem|
      elem.none? { |num| num < 0 || num > 7 }
    end

    valid.each { |elem| node.add_neighbor(find_cell(elem)) }
  end

  def find_cell(array)
    @board[array[0] * 8 + array[1]]
  end

  def connect_nodes
    @board.each {|node| get_neighbors(node)}
  end

  def bfs(start, end_pos)
    start_node = find_cell(start)
    queue = [start_node]
    result = []

    until queue.empty?
      queue[0].neighbors.each { |node| queue.push(node).uniq! }
      current_node = queue.shift
      result.push(current_node)

      break if current_node.position == end_pos
    end

    result
  end
end

class Node
  def initialize(position)
    @position = position
    @neighbors = []
  end

  def add_neighbor(node)
    @neighbors.push(node)
  end

  def position
    [@position[0], @position[1]]
  end

  def neighbors
    @neighbors.clone
  end
end

board = Board.new
board.make_cells
board.connect_nodes

result = board.bfs([3, 3], [4, 3])

def knight_moves(start_pos, end_pos)
  board.bfs(start_pos, end_pos)
end

result.each { |node| print "#{node.position} \n"}
