require_relative 'target_set'

class TargetingSetSplitter
  def split(target)
    return split_dimension(TargetSet.new, target, [:countries, :placements, :gender_expanded, :age_range_expanded]).to_a
  end

  def split_dimension(template, target, dimensions)
    sets = Set[]
    dimension = dimensions.pop

    target.send(dimension).each do |val| 
      clone = template.clone
      if dimension.to_s.index('_expanded').nil?
        clone.send("#{dimension}=", [val])
      else
        clone.send("#{dimension.to_s.sub('_expanded', '')}=", val)
      end

      if dimensions.size == 0
        sets.add(clone)
      else
        sets.merge(split_dimension(clone, target, dimensions.clone))
      end
    end
    return sets
  end
end
