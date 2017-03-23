class BFS
  attr_accessor :graph, :search_queue, :searched, :found

  def initialize(graph)
    @graph = graph
    @search_queue = []
    @searched = []
    @found = false
  end

  def search(name)
    @search_queue << graph[name]

    while search_queue && !found
      person = search_queue.shift
      search_connections(person)
    end
  end

  def search_connections(connections)
    connections.each do |connection|
      unless searched.include? connection
        if person_is_seller(connection)
          puts connection + ' is a mango seller!'
          @found = true
          break
        else
          puts connection + " isn't a mango seller!"
          search_queue.push graph[connection]
          searched << connection
        end
      end
    end
  end

  def person_is_seller(name)
    name[-1] == 'm'
  end
end

graph = {}
graph['you'] = %w(alice bob claire)
graph['bob'] = %w(anuj peggy)
graph['alice'] = ['peggy']
graph['claire'] = %w(thom jonny)
graph['anuj'] = []
graph['peggy'] = []
graph['thom'] = []
graph['jonny'] = []

BFS.new(graph).search('you')
