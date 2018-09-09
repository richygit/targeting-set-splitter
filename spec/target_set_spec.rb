require_relative '../target_set'
require 'rspec'

RSpec.describe TargetSet do
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

  describe '#decimal_end' do
    context 'when not a round decimal number' do
      it 'should return the next higher decimal number' do
        expect(subject.decimal_end(1)).to eq(10)
        expect(subject.decimal_end(24)).to eq(30)
      end
    end

    context "when it's a decimal number" do
      it 'should return itself' do
        expect(subject.decimal_end(0)).to eq(0)
        expect(subject.decimal_end(90)).to eq(90)
      end
    end
  end
    
  describe '#gender_expanded' do
    it 'should return the expanded gender set' do
      subject.gender = 0
      expect(subject.gender_expanded).to match_array([0])

      subject.gender = 1
      expect(subject.gender_expanded).to match_array([1])

      subject.gender = 2
      expect(subject.gender_expanded).to match_array([0,1])
    end
  end

  describe '#age_range_expanded' do
    it 'should return the expanded age ranges' do
      subject.age_range = [0,0]
      expect(subject.age_range_expanded).to match_array([[0,0]])

      subject.age_range = [1,2]
      expect(subject.age_range_expanded).to match_array([[1,2]])

      subject.age_range = [8,11]
      expect(subject.age_range_expanded).to match_array([[8,10], [11, 11]])

      subject.age_range = [8,30]
      expect(subject.age_range_expanded).to match_array([[8,10], [11, 20], [21,30]])
    end
  end

  describe '#eql?' do
    context 'with equal target sets' do
      it 'should return true' do
        expect(target_set.eql?(target_set)).to be true
        expect(target_set.eql?(target_set.clone)).to be true
      end
    end

    context 'with unequal target sets' do
      it 'should return false' do
        expect(target_set.eql?(diff_countries)).to be false
        expect(target_set.eql?(diff_placement)).to be false
        expect(target_set.eql?(diff_gender)).to be false
        expect(target_set.eql?(diff_age)).to be false
      end
    end
  end
end
