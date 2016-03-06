require 'open-uri'
require 'nokogiri'
require 'pp'
require 'benchmark'
require 'yaml'

class ImdbParser

@main_uri = "http://www.imdb.com"
@top250_uri = "http://www.imdb.com/chart/top"
ATTR = %w[refer name date country premier genre length rating director actors]

  class << self

    def get_top_uri
      page = Nokogiri::HTML(open(@top250_uri))
      top250 = page.css('td.titleColumn > a').map { |a| "#{@main_uri}#{a['href'].split('?').first}" }
    end

    def get_movie(url, movie_page)
      title = movie_page.css('div.originalTitle').text.split('(').first
      date = movie_page.css('span[id="titleYear"] > a').first.text
      country = movie_page.css('h4.inline:contains("Country") + a').first.text
      premier = movie_page.css('meta[itemprop="datePublished"]').first['content']
      genre = movie_page.css('span.itemprop[itemprop="genre"]').map { |genre| genre.text }.join(',')
      unless (movie_page.css('div.txt-block > time[itemprop="duration"]')[0].nil?)
        length = movie_page.css('div.txt-block > time[itemprop="duration"]')[0].text
      else
        length = "missing_data" 
      end
      rating = movie_page.css('span[itemprop="ratingValue"]').first.text
      director = movie_page.css('span[itemprop="director"] > a').first.text
      actors = movie_page.css('span[itemprop="actors"] > a').map { |actor| actor.text }.join(',')

      String.new("#{url}|#{title}|#{date}|#{country}|#{premier}|#{genre}|#{length}|#{rating}|#{director}|#{actors}").encode("utf-8")
    end

    def parse_movies
      self.get_top_uri.map do |url|
      	movie_page = Nokogiri::HTML(open(url))
        get_movie(url, movie_page)
      end
    end
=begin
    def parse_movies_test(number)
      self.get_top_uri[0..number].map do |url|
        movie_page = Nokogiri::HTML(open(url))
        get_movie(url, movie_page)
      end
    end
=end
    def parse_to_file(name)
      File.open("#{name}.txt", "w") { |file| file.write self.parse_movies.join("\n") }
    end

    def movie_to_hash(movie)
      Hash[ATTR.zip(movie.split('|'))]
    end

    def parse_to_yaml(name)
      i = 0
      File.open("#{name}.yaml", "w") do |file|
        file.write self.parse_movies.each_with_index.map { |movie, index|  { "movie_#{index+1}" => self.movie_to_hash(movie) } }.to_yaml
      end
    end

  end
end
=begin
movie_url = ImdbParser.get_top_uri[0]
movie_page = Nokogiri::HTML(open(movie_url))
#pp movie_page.css('div.originalTitle').text
movie = ImdbParser.get_movie(movie_url, movie_page)
puts [ { "1" => ImdbParser.movie_to_hash(movie) } ].to_yaml
#puts movie_to_yaml
=end
ImdbParser.parse_to_yaml("imdb_yaml")
#time = Benchmark.measure { ImdbParser.parse_to_file("imdb_base") }
#puts "Done! It takes: #{time}"