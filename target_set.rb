require 'set'

class TargetSet
  attr_accessor :countries, :placements, :gender, :age_range

  def initialize(countries=nil, placements=nil, gender=nil, age_range=nil)
    self.countries = countries
    self.placements = placements
    self.gender = gender
    self.age_range = age_range
  end

  def gender_expanded
    return self.gender == 2 ? [0,1] : [self.gender]
  end

  def decimal_end(num)
    return num if num%10 == 0
    return ((num/10)+1) * 10
  end

  def age_range_expanded
    age_start, age_end = self.age_range
    ages_set = []
    set_start = age_start
    set_end = decimal_end(set_start)

    while set_end < age_end
      ages_set << [set_start, set_end]
      set_start = set_end + 1
      set_end = decimal_end(set_start)
    end

    set_end = age_end if age_end < set_end
    ages_set << [set_start, set_end]
    return ages_set
  end

  def ==(other)
    return eql?(other)
  end

  def eql?(other)
    return other.instance_of?(TargetSet) && 
      self.countries.eql?(other.countries) &&
      self.placements.eql?(other.placements) &&
      self.gender == other.gender && 
      self.age_range.eql?(other.age_range)
  end

  def hash
    return [countries, placements, gender, age_range].hash
  end

  def inspect
    return self.to_s
  end

  def to_s
    return "TargetSet[c: #{self.countries.to_s}, p: #{self.placements.to_s}, g: #{self.gender}, a: #{self.age_range}]"
  end

  def validate!
      validate_countries!
      validate_age_range!
      validate_placements!
      #validate_gender!
  end

private

  def validate_countries!
    if self.countries.nil? or self.countries.size < 1
      raise ArgumentError.new("At least 1 country required") 
    end

    if !self.countries.nil? and self.countries.size > 200
      raise ArgumentError.new("Maximum 200 countries allowed") 
    end
  end
  
  def validate_age_range!
    if self.age_range.nil? or self.age_range.size != 2
      raise ArgumentError.new('Start age and end age are required') 
    end

    if self.age_range[0] < 0 or self.age_range[1] < 0
      raise ArgumentError.new('Start and end age must be positive')
    end

    if self.age_range[0] > self.age_range[1]
      raise ArgumentError.new('Start age must be lower than end age')
    end
  end
  
  def validate_placements!
    if self.placements.nil? or !(1..6).include?(self.placements.size)
      raise ArgumentError.new('Between 1 and 6 placements required')
    end
  end
end
