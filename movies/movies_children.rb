class AncientMovie < Movie
  filter { |year| (1900..1936).cover?(year) }
  print_format "%{name} - старый фильм, %{date}"

  def initialize(*args)
    super
  @weight = 0.7
  end
end

class ClassicMovie < Movie
  filter { |year| (1937..1968).cover?(year) }
  print_format "%{name} - классический фильм, режиссер: %{director}"

  def initialize(*args)
    super
  @weight = 0.8
  end
end

class ModernMovie < Movie
 filter { |year| (1969..2000).cover?(year) }
 print_format "%{name}- современный фильм, играют %{actors}"

  def initialize(*args)
    super
  @weight = 0.9
  end
end

class NewMovie < Movie
  filter { |year| (2001..2016).cover?(year) }
  print_format "%{name} - новинка!"

  def initialize(*args)
    super
  @weight = 1.0
  end
end