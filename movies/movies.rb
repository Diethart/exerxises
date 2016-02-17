require 'date'

class Movie
  attr_accessor :refer, :name, :country, :genre, :rating, :director
  def initialize(*args)
    @refer, @name, @date, @country, @premier, @genre, @length, @rating, @director, @actors = args
  end
  
  def to_s
    "Name: #{@name}  Length: #{@length}  Genre: #{genre} Country: #{@country}" 
  end
  
  def length
    @length.to_i
  end
  
  def date
    Date.strptime(@date, '%Y').year
  end
  
  def premier
    if @premier.length > 5 and @premier.length < 8
	  Date.strptime(@premier, "%Y-%m")
	elsif @premier.length > 8
	  Date.strptime(@premier, "%Y-%m-%d")
	else 
	  nil
	end
  end
  
  def actors
    @actors.split(',')
  end
end
