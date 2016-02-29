class MyMoviesList < MoviesList
  def initialize(file, separator)
    @movies = CSV.read(file, {col_sep: separator}).map do |film|
      case film[2].to_i
      when 1900..1945
        AncientMovie.new(*film)
      when 1946..1968
        ClassicMovie.new(*film)
      when 1969..2000
        ModernMovie.new(*film)
      when 2000..2016
        NewMovie.new(*film)
      end
    end
  end
end