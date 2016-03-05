require 'open-uri'
require 'nokogiri'
require 'pp'
require 'benchmark'

class ImdbParser

@main_uri = "http://www.imdb.com"
@top250_uri = "http://www.imdb.com/chart/top"

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

    def parse_to_file(name)
      File.open("#{name}.txt", "w") { |file| file.write self.parse_movies.join("\n") }
    end

  end
end

#movie_page = Nokogiri::HTML(open(ImdbParser.get_top_uri[212]))
#pp movie_page.css('div.originalTitle').text

time = Benchmark.measure { ImdbParser.parse_to_file("imdb_base") }
puts "Done! It takes: #{time}"