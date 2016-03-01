require_relative 'movies'
require_relative 'movies_list'
require_relative 'my_movies_list'
require_relative 'movies_children'
require 'pp'
require 'date'

movies = MoviesList.new(ARGV[0],"|")

#puts movies.longest(5)
#puts movies.select_genre("COMEDY")
#puts movies.reject_genre("COMEDY")
#puts movies.select_country("USA")
#puts movies.reject_country("USA")
#puts movies.director_stat
#puts movies.director_names
#pp movies.actors_stat
#pp movies.month_stat

#puts movies.new_recomendation

=begin
movies.add_seen("The Shawshank Redemption", 9)
movies.add_seen("The Godfather", 8)
movies.add_seen("The Godfather: Part II", 7)
movies.add_seen("Pulp Fiction", 10)
movies.add_seen("Goodfellas", 6)
movies.add_seen("The Matrix", 10)

puts movies.seen_recomendation
=end

#movies.print {|film| puts "#{film.name} #{film.premier} #{film.director}"}



#movies.add_sort_algo(:genre_year) { |film| [film.genre, film.date] }
#puts movies.sorted_by(:genre_year)

puts movies.sorted_by { |film| [film.genre, film.date] }