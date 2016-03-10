require_relative 'module_rating'

class MyMoviesList < MoviesList
  include Rating
  def initialize(file)
  	super
  	@rating = {}
  end
end
