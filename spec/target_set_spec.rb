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

    context 'members are not the same' do
      specify { expect(target_set.eql?(diff_countries)).to be false }
      specify { expect(target_set.eql?(diff_placement)).to be false }
      specify { expect(target_set.eql?(diff_gender)).to be false }
      specify { expect(target_set.eql?(diff_age)).to be false }
    end
  end

  describe '#hash' do
    it 'should return true when members are the same' do
      expect(target_set.hash).to eq(target_set.clone.hash)
    end

    context 'members are not the same' do
      specify { expect(target_set.hash).not_to eq(diff_countries.hash) }
      specify { expect(target_set.hash).not_to eq(diff_placement.hash) }
      specify { expect(target_set.hash).not_to eq(diff_gender.hash) }
      specify { expect(target_set.hash).not_to eq(diff_age.hash) }
    end
  end
end
