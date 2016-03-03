require 'date'
require 'pp'

class Movie
  attr_accessor :refer, :name, :country, :genre, :director
  attr_reader :weight
  @@filters = {}
  @@print_formats = {}
  def initialize(*args)
    @refer, @name, @date, @country, @premier, @genre, @length, @rating, @director, @actors = args
  end

  def Movie.filter(&block)
    @@filters[self] = block
  end

  def Movie.print_format(format)
    @@print_formats[self] = format
  end

  def print
    puts instance_eval(@@print_formats[self.class])
  end

  def Movie.create(*data)
    movie = 0
    @@filters.each_pair { |name, construct| construct.call(data[2].to_i) ? movie = name.new(*data) : next }
    movie
  end

  def to_s
    "Name: #{@name}  Length: #{@length}  Genre: #{genre} Country: #{@country} Date: #{@date}" 
  end
  
  def length
    @length.to_i
  end
  
  def rating
    @rating.to_i
  end
  
  def date
    @date.to_i
  end
  
  def premier
    case @premier.length
    when 7
      Date.strptime(@premier, "%Y-%m")
    when 10
      Date.strptime(@premier, "%Y-%m-%d")
    else
      nil
    end
  end
  
  def actors
    @actors.split(',')
  end

  def method_missing(name)
    @genre.split(',').include? name.to_s.capitalize.chop
  end
end