require_relative 'movies'
require_relative 'movies_children'
require_relative 'movies_list'
require_relative 'my_movies_list'
require 'pp'
require 'date'
require 'nokogiri'


#movies = MyMoviesList.new(ARGV[0],"|")
#movies[0].to_s

#ТЕСТИРОВАНИЕ БАЗОВЫХ МЕТОДОВ СПИСКА ФИЛЬМОВ
#puts movies.longest(5)
#puts movies.select_genre("COMEDY")
#puts movies.reject_genre("COMEDY")
#puts movies.select_country("USA")
#puts movies.reject_country("USA")
#puts movies.director_stat
#puts movies.director_names
#pp movies.actors_stat
#pp movies.month_stat

#ВЫВОД СПИСКА НЕПРОСМОТРЕННЫХ ФИЛЬМОВ
#puts movies.new_recomendation

#ВЫВОД СПИСКА ПРОСМОТРЕННЫХ ФИЛЬМОВ
=begin 
movies.add_seen("The Shawshank Redemption", 9)
movies.add_seen("The Godfather", 8)
movies.add_seen("The Godfather: Part II", 7)
movies.add_seen("Pulp Fiction", 10)
movies.add_seen("Goodfellas", 6)
movies.add_seen("The Matrix", 10)

puts movies.seen_recomendation
=end

#ВЫВОД НА ЭКРАН В ЗАДАННОМ ВИДЕ
#movies.print {|film| puts "#{film.name} #{film.premier} #{film.director}"}

#СОРТИРОВКА ПО АЛГОРИТМУ
=begin
movies.add_sort_algo(:genre_year) { |film| [film.genre, film.date] }
puts movies.sorted_by(:genre_year)
puts movies.sorted_by { |film| [film.genre, film.date] }
=end

#СОРТИРОВКА ПО ФИЛЬТРАМ
=begin
movies.add_filter(:genres){|movie, *genres| genres.any?{ |genre| movie.genre.include? genre } }
movies.add_filter(:years){|movie, from, to| (from..to).include?(movie.date)}
movies.add_filter(:rating_greater){|movie, rating| movie.rating>rating }

puts movies.filter(
    genres: ['Drama'],
    years: [1990, 2015],
    rating_greater: [8]
  )
=end

#ИСПОЛЬЗОВАНИЕ methos_missing
#puts movies[0].comedy?

#ВЫВОД ЧЕРЕЗ print
#movies[0].print