require_relative 'module_rating'

class MyMoviesList < MoviesList
  include Rating

  def initialize(file, separator)
    super
    @rating = Hash.new(0)
  end
end
