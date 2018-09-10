require_relative 'target_set'

class TargetingSetSplitter
  def split(target)
    target.validate!
    sets = target.countries.collect do |country| 
      target.placements.collect do |placement|
        target.gender_expanded.collect do |gender|
          target.age_range_expanded.collect do |age_range|
            TargetSet.new([country],[placement],gender,age_range)
          end
        end
      end
    end
    return sets.flatten
  end
end
