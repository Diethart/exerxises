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

class AncientMovie < Movie
  def initialize(*args)
    super
	@weight = 0.7
  end
  
  def to_s
    "#{@name} - старый фильм, #{@date.to_i}"
  end
end

class ClassicMovie < Movie
  def initialize(*args)
    super
	@weight = 0.8
  end
  
  def to_s
    "#{@name} - классический фильм, #{@director}"
  end
end

class ModernMovie < Movie
  def initialize(*args)
    super
	@weight = 0.9
  end
  
  def to_s
    "#{@name} - современный фильм, играют #{@actors}"
  end
end

class NewMovie < Movie
  def initialize(*args)
    super
	@weight = 1.0
  end
  
  def to_s
    "#{@name} - новинка, сборы 100$ млн!"
  end
end


