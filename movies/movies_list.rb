require 'ostruct'
require 'csv'
require 'date'
require_relative 'movies'
require_relative 'movies_children'

class MoviesList
  attr_reader :movies
  alias_method :list, :movies

  def initialize(file, separator)
    @movies = CSV.read(file, {col_sep: separator}).map { |film| make_movie(film) }
    @sort_algo = Hash.new(0)
  end

  def make_movie(film)
       Movie.new(*film)
  end
  
  def [](index)
    @movies[index]
  end
  
  def longest(numbers)
    @movies.sort_by(&:length).reverse.first(numbers)
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
    @movies.group_by(&:director).map { |director, films| "Director:#{director}  Movies: #{films.length}" }
  end
  
  def director_names
    @movies.map(&:director).uniq.sort_by { |director| director.split(' ').last }
  end
  
  def actors_stat
    @movies.map(&:actors).flatten.reduce(Hash.new(0)) do |actors, actor| 
    actors[actor] += 1 
    actors
    end
  end
  
  def month_stat
    @movies.select(&:premier).compact.reduce(Hash.new(0)) do |stat, film| 
    stat[film.premier.month] += 1
    stat
    end
  end

=begin
  def print
    @movies.each do |film|
      if block_given?
        puts yield film
      else
        puts film
      end
    end
  end

  def sorted_by(&block)
    @movies.sort_by { |film| block.call(film) }
  end
=end

  def print(&block)
    block ||= proc{ |film| film.to_s }
    @movies.each { |film| puts block.call(film) }
  end

  def sorted_by(name, &block)
    algo = @sort_algo[name] || block
    p algo
    #@movies.sort_by(&algo)
  end

  def add_sort_algo(name, &block)
    @sort_algo[name] = block
  end
end