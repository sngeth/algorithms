require "scanf"
require "byebug"

class EdgeNode
  attr_accessor :y, :weight, :next

  def initialize(y = nil, weight = nil, next_edge = nil)
    # Represent directed edge (x, y) by an edge node y in x's adjacency list
    # An undirected edge (x, y) appears twice in any adjacency-based graph
    @y = y
    @weight = weight
    @next_edge = next_edge
  end
end


class Graph
  MAXV = 1000
  attr_accessor :edges, :degree, :num_vertices, :num_edges, :directed

  def initialize(directed = false)
    @degree = []
    @num_vertices = 0
    @num_edges = 0
    @directed = directed

    (1..MAXV).each { |i| degree[i] = 0 }
  end

  def read_graph
    array = scanf("%d %d")
    @num_vertices, @num_edges = array

    (1..num_edges).each do |i|
      x, y = scanf("%d %d")
      insert_edge(x, y, directed)
    end
  end

  def insert_edge(x, y, directed)
    p = EdgeNode.new

    p.weight = 0
    p.y = y
    p.next_edge = edges[x]

    edges[x] = p

    degree[x] += 1

    if directed == false
      insert_edge(y, x, true)
    else
      num_edges += 1
    end
  end

  def print_graph
    p = EdgeNode.new

    (1..num_edges).each do |i|
      puts "#{i}"
      p = edges[i]
      while (p != nil)
        puts " #{p.y}"
        p = p.next_edge
      end
    end
  end
end
