require 'date'
require 'pp'

class Movie

  class << self
    def print_format(fmt); @format = fmt end
    attr_reader :format
  end

  attr_accessor :refer, :name, :country, :genre, :director
  attr_reader :weight
  @@filters = {}
  def initialize(*args)
    @refer, @name, @date, @country, @premier, @genre, @length, @rating, @director, @actors = args
  end

  def Movie.filter(&block)
    @@filters[self] = block
  end

  def to_s
    puts self.class.format % to_h
  end

  def Movie.create(*data)
    @@filters.find { |name, block| block.call(data[2].to_i) }.first.new(*data)
  end

  def to_h
    { refer: @refer, name: @name, date: @date, country: @country, premier: @premier, genre: @genre, length: @length, rating: @rating, director: @director, actors: @actors }
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