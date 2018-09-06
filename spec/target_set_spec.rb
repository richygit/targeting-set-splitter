require_relative '../target_set'
require 'rspec'

RSpec.describe 'target_set' do
  let(:target_set) { TargetSet.new(['hk'], ['desktop'], 0, 13..20) }
  let(:diff_countries) { TargetSet.new(['jp'], ['desktop'], 0, 13..20) }
  let(:diff_placement) { TargetSet.new(['hk'], ['mobile'], 0, 13..20) }
  let(:diff_gender) { TargetSet.new(['hk'], ['desktop'], 1, 13..20) }
  let(:diff_age) { TargetSet.new(['hk'], ['desktop'], 0, 21..30) }

  describe '#eql?' do
    it 'should return true when members are the same' do
      expect(target_set.eql?(target_set.clone)).to be true
    end

    it 'should return false when members are not the same' do
      expect(target_set.eql?(diff_countries)).to be false
    end
  end

  describe '#hash' do
    it 'should return true when members are the same' do
    end

    it 'should return false when members are not the same' do
    end
  end
end
