require 'set'

class TargetSet
  attr_accessor :countries, :placements, :gender, :age_range

  def initialize(countries, placements, gender, age_range)
    self.countries = countries
    self.placements = placements
    self.gender = gender
    self.age_range = age_range
  end

  def ==(other)
    return eql?(other)
  end

  def gender_expanded
    return [self.gender]
  end

  def age_range_expanded
    return [self.age_range]
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
end
