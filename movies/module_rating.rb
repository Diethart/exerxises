require 'date'
module Rating
  attr_accessor :rating

  def seen?(film)
    @rating.has_key?(film)
  end

  def seen 
    list.select { |film| seen?(film.name) }
  end
  
  def not_seen
    list.reject { |film| seen?(film.name) }
  end

  def new_recomendation
    not_seen.sort_by { |film| film.rating * rand(100) * film.weight }.reverse.first(5)
  end

  def add_seen(name, rating)
  	@rating[name] = [rating, Date.today]
  end

  def seen_recomendation
    seen.sort_by { |film|
      rating, date = @rating[film.name]
      rating * (Date.today - date) * rand(10) }.reverse.first(5)
  end
end
