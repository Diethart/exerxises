class Movie
  attr_accessor :refer, :name, :date, :country, :premier, :genre, :length, :rating, :director, :actors
  
  def initialize(*args)
    @refer, @name, @date, @country, @premier, @genre, @length, @rating, @director, @actors = args
  end
  
  def to_s
    "Name: #{@name}" + "\n" + "Length: #{@length}" + "\n" + "Genre: #{genre}" 
  end
end
