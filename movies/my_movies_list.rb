require_relative 'module_rating'

class MyMoviesList < MoviesList
  include Rating

  def initialize(file, separator)
    super
    @rating = Hash.new(0)
  end

  def make_movie(film)
    case film[2].to_i
    when 1900..1945
      AncientMovie.new(*film)
    when 1946..1968
      ClassicMovie.new(*film)
    when 1969..2000
      ModernMovie.new(*film)
    when 2000..2016
      NewMovie.new(*film)
    end
  end
end
