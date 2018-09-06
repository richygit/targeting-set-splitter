require 'set'

class TargetSet
  attr_accessor :countries, :placement, :gender, :age_range

  def initialize(countries, placement, gender, age_range)
    self.countries = countries.to_set
    self.placement = placement.to_set
    self.gender = gender
    self.age_range = age_range
  end

  def eql?(other)
    return self.countries.eql?(other.countries) &&
      self.placement.eql?(other.placement) &&
      self.gender == other.gender && 
      self.age_range.eql?(other.age_range)
  end

  def hash
    return [countries, placement, gender, age_range].hash
  end
end
