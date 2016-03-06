require_relative 'module_rating'

class MyMoviesList < MoviesList
  include Rating
  @rating = {}
end
