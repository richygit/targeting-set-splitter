require_relative 'target_set'

class TargetingSetSplitter
  def split(target)
    #TODO validation
    return split_dimension(target, [:countries, :placements, :gender_expanded, :age_range_expanded]).to_a
  end

  def split_dimension(target, dimensions)
    sets = Set[]
    dimension = dimensions.pop

    target.send(dimension).each do |val| 
      clone = target.clone
      if dimension.to_s.index('_expanded').nil?
        clone.send("#{dimension}=", [val])
      else
        clone.send("#{dimension.to_s.sub('_expanded', '')}=", val)
      end

      if dimensions.size == 0
        sets.add(clone)
      else
        sets.merge(split_dimension(clone, dimensions))
      end
    end
    return sets
  end
end
