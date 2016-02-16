require 'ostruct'
require 'csv'
require 'date'
require_relative 'movie'

class MoviesList
  @movies
  def initialize(file, separator)
    @movies = CSV.read(file, {col_sep: separator}).map { |film| Movie.new(*film) }
  end
  
  def [](index)
    @movies[index]
  end
  
  def longest(numbers)
    @movies.sort_by { |film| film.length.to_i }.reverse.first(numbers)
  end
  
  def select_genre(genre)
    @movies.select { |film| film.genre.include? genre.capitalize }
  end
  
  def reject_genre(genre)
    @movies.reject { |film| film.genre.include? genre.capitalize }
  end
  
  def select_country(country)
    @movies.select { |film| film.country.include? country }
  end
  
  def reject_country(country)
    @movies.reject { |film| film.country.include? country }
  end
  
  def director_stat
    @movies.group_by(&:director).map { |director, films| "Director: #{director}"+ "\n" + "Movies: #{films.length}" }
  end
  
  def director_names
    @movies.map(&:director).uniq.sort_by { |director| director.split(' ').last }
  end
  
  def actors_stat
    @movies.map {|film| film.actors.split(',')}.flatten.reduce(Hash.new(0)) do |actors, actor| 
    actors[actor] += 1 
    actors
	end
  end
  
  def month_stat
    @movies.reject{|film| film.premier.length<5 }.reduce(Hash.new(0)) do |stat, film| 
    stat[Date.strptime(film.premier,'%Y-%m').month] += 1
    stat
    end
  end
end
