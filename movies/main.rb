require_relative 'movie'
require_relative 'movies_list'

movies = MoviesList.new(ARGV[0],"|")
movies.select_genre("COMEDY").each { |film| puts film.to_s }
