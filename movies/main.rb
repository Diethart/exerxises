require_relative 'movies'
require_relative 'movies_list'
require_relative 'my_movies_list'
require_relative 'movies_children'
require 'pp'

movies = MyMoviesList.new(ARGV[0],"|")

#puts movies.longest(5)
#puts movies.select_genre("COMEDY")
#puts movies.reject_genre("COMEDY")
#puts movies.select_country("USA")
#puts movies.reject_country("USA")
#puts movies.director_stat
#puts movies.director_names
#pp movies.actors_stat
#pp movies.month_stat
