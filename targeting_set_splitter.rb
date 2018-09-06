require_relative 'target_set'

class TargetingSetSplitter
  def split(target)
    memo = Set[]
    split_countries(target, memo)
    return memo
  end

  def split_countries(target, memo)
    target.countries.each do |country| 
      clone = target.clone
      clone.countries = Set[country]
      memo.add(clone)
    end
  end
end
