require 'date'
require 'pp'

class Movie

  attr_reader :weight
  @@filters = {}
  @attributes = {}
  ATTR = %w[refer name date country premier genre length rating director actors]

  class << self
    attr_reader :format
    def print_format(fmt); @format = fmt end
    
    def Movie.filter(&block)
      @@filters[self] = block
    end

    def Movie.create(hash)
      @@filters.find { |name, block| block.call(hash[:date].to_i) }.first.new(hash)
    end
  end
  
  def initialize(hash)
    @attributes = hash.clone
  end
  
  ATTR.each { |action| define_method(action) { @attributes[action.to_sym] } }

  def to_s
    self.class.format % to_h
  end

  def to_h
    @attributes
  end

  def method_missing(name)
    self.genre.split(',').include? name.to_s.capitalize.chop
  end
end