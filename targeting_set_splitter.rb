require_relative 'target_set'

class TargetingSetSplitter
  def split(target)
    target.validate!
    sets = target.countries.collect do |c| 
      target.placements.collect do |p|
        target.gender_expanded.collect do |g|
          target.age_range_expanded.collect do |a|
            TargetSet.new([c],[p],g,a)
          end
        end
      end
    end
    return sets.flatten
  end
end
