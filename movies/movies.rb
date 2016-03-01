require 'date'

class Movie
  attr_accessor :refer, :name, :country, :genre, :director
  attr_reader :weight
  def initialize(*args)
    @refer, @name, @date, @country, @premier, @genre, @length, @rating, @director, @actors = args
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
end