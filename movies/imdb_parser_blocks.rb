class ImdbParser
private 
  @blocks = {}
  @main_uri = "http://www.imdb.com"
  @top250_uri = "http://www.imdb.com/chart/top"
    def self.define_block(name, &block)
      @blocks[name] = block
    end

    define_block("title") { |page| page.css('div.originalTitle').text.split('(').first }
    define_block("date") { |page| page.css('span[id="titleYear"] > a').first.text }
    define_block("country") { |page| page.css('h4.inline:contains("Country") + a').first.text }
    define_block("premier") { |page| page.css('meta[itemprop="datePublished"]').first['content'] }
    define_block("genre") { |page| page.css('span.itemprop[itemprop="genre"]').map { |genre| genre.text }.join(',') }
    define_block("length") { |page| result = page.css('div.txt-block > time[itemprop="duration"]')[0]; result.nil? ? ("missing_data") : (result.text) }
    define_block("rating") { |page| page.css('span[itemprop="ratingValue"]').first.text }
    define_block("director") { |page| page.css('span[itemprop="director"] > a').first.text }
    define_block("actors") { |page| page.css('span[itemprop="actors"] > a').map { |actor| actor.text }.join(',') }
end
