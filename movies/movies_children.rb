class AncientMovie < Movie
  def initialize(*args)
    super
  @weight = 0.7
  end
  
  def to_s
    "#{@name} - старый фильм, #{@date.to_i}"
  end
end

class ClassicMovie < Movie
  def initialize(*args)
    super
  @weight = 0.8
  end
  
  def to_s
    "#{@name} - классический фильм, #{@director}"
  end
end

class ModernMovie < Movie
  def initialize(*args)
    super
  @weight = 0.9
  end
  
  def to_s
    "#{@name} - современный фильм, играют #{@actors}"
  end
end

class NewMovie < Movie
  def initialize(*args)
    super
  @weight = 1.0
  end
  
  def to_s
    "#{@name} - новинка!"
  end
end