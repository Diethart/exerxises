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
    seen.sort_by { |film| date_n_rating(film.name) * rand(10) }.reverse.first(5)
  end

  def date_n_rating(film)
    @rating[film][0] + (Date.today - @rating[film][1]).to_i
  end
end
