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

    array = array.map { |elem| elem.map.with_index { |coordinate, i| coordinate + position[i] } }

    valid = array.select do |elem|
      elem.none? { |num| num < 0 || num > 7 }
    end

    valid.each { |elem| node.add_neighbor(find_cell(elem)) }
  end

  def find_cell(array)
    @board[array[0] * 8 + array[1]]
  end

  def connect_nodes
    @board.each { |node| get_neighbors(node) }
  end

  def bfs(start, end_pos)
    start_node = find_cell(start)
    queue = [start_node]
    last_node = find_cell(end_pos)
    index = 0

    loop do
      queue[index].neighbors.each do |node|
        next if queue.include?(node)

        node.previous = queue[index]
        queue.push(node).uniq!
      end

      index += 1

      break if queue.include?(last_node)
    end

    queue
  end

  def create_path(node_array)
    current_node = node_array.last
    path = [current_node]

    loop do
      current_node = current_node.previous
      path.unshift(current_node)

      break if current_node == node_array.first
    end

    path
  end
end

class Node
  attr_accessor :previous

  def initialize(position)
    @position = position
    @neighbors = []
    @previous = nil
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

def knight_moves(start_pos, end_pos)
  board = Board.new
  board.make_cells
  board.connect_nodes

  result = board.bfs(start_pos, end_pos)
  path = board.create_path(result)

  puts "You made it in #{path.length - 1} moves! Here's your path:\n\n"
  path.each { |node| print "#{node.position} \n" }
end

knight_moves([1, 2], [5, 2])
