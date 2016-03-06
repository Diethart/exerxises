require 'ostruct'
require 'csv'
require 'date'
require 'yaml'
require_relative 'movies'
require_relative 'movies_children'


class MoviesList
  attr_reader :movies
  alias_method :list, :movies


  def initialize(file)
    hashes = YAML.load_file(file)
    @movies = hashes.map { |hash| Movie.create(hash) }
    @sort_algo = {}
    @filters = {}
  end
  
  def [](index)
    @movies[index]
  end
  
  def longest(numbers)
    @movies.sort_by{|movie| movie.length.to_i}.reverse.first(numbers)
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
    @movies.map{ |movie| movie.actors.split(',') }.flatten.reduce(Hash.new(0)) do |actors, actor| 
    actors[actor] += 1 
    actors
    end
  end
=begin
  def month_stat
    @movies.select(&:premier).compact.reduce(Hash.new(0)) do |stat, film| 
    stat[Date.new(film.premier).month] += 1
    stat
    end
  end
=end  
  def print(&block)
    block ||= proc{ |film| film.to_s }
    @movies.each { |film| puts block.call(film) }
  end

  def sorted_by(name=nil, &block)
    @movies.sort_by(&(@sort_algo[name] || block))
  end

  def add_sort_algo(name, &block)
    @sort_algo[name] = block
  end

  def filter(filters)
    movies = @movies.clone
    filters.each_pair { |action, value| movies.select! {|movie| @filters[action][movie,*value]} }  
    movies
  end

  def add_filter(name, &block)
    @filters[name] = block
  end
end