require 'open-uri'
require 'nokogiri'
require 'pp'
require 'benchmark'
require 'yaml'
require_relative 'imdb_parser_blocks'

class << ImdbParser

  ATTR = [:refer, :name, :date, :country, :premier, :genre, :length, :rating, :director, :actors]
  private
    def get_top_uri
      page = Nokogiri::HTML(open(@top250_uri))
      top250 = page.css('td.titleColumn > a').map { |a| "#{@main_uri}#{a['href'].split('?').first}" }
    end

    def call_block(name, data)
      @blocks[name].call(data)
    end

    def parse_movies
      get_top_uri.map do |url|
      	get_movie(url)
      end
    end

    def parse_movies_test(number)
      get_top_uri[0..number].map do |url|
        get_movie(url)
      end
    end

  public
    def get_movie(url)
      page = Nokogiri::HTML(open(url))
      Hash[ATTR.zip(@blocks.map { |key, block| block.call(page) }.unshift(url))]
    end

    def parse_to_yaml(name)
      File.open("#{name}.yaml", "w") do |file|
        file.write parse_movies.to_yaml
      end
    end
end

ImdbParser.parse_to_yaml("imbd_base")