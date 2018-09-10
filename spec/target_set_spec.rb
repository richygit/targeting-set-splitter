require_relative '../target_set'

RSpec.describe TargetSet do
  let(:target_set) { TargetSet.new(['hk'], ['desktop'], 0, [13,20]) }
  let(:diff_countries) { TargetSet.new(['jp'], ['desktop'], 0, [13,20]) }
  let(:diff_placement) { TargetSet.new(['hk'], ['mobile'], 0, [13,20]) }
  let(:diff_gender) { TargetSet.new(['hk'], ['desktop'], 1, [13,20]) }
  let(:diff_age) { TargetSet.new(['hk'], ['desktop'], 0, [21,30]) }

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

  describe 'validate!' do
    context 'countries: ' do
      context 'with no countries' do
        it 'should raise an error' do
          target_set.countries = []
          expect{ target_set.validate! }.to raise_error(ArgumentError, /at least 1 country/i)
        end
      end
      context 'when more than 200 countries' do
        it 'should raise an error' do
          target_set.countries = ('aa'..'zz').to_a
          expect{ target_set.validate! }.to raise_error(ArgumentError, /maximum 200/i)
        end
      end
    end

    context 'placement: ' do
      context 'with invalid number of placements' do
        it 'should raise an error' do
          target_set.placements = []
          expect{ target_set.validate! }.to raise_error(ArgumentError, /between 1 and 6 placements/i)

          target_set.placements = ['1', '2', '3', '4', '5', '6', '7']
          expect{ target_set.validate! }.to raise_error(ArgumentError, /between 1 and 6 placements/i)
        end
      end
    end

    context 'gender: ' do
      context 'with invalid gender number' do
        it 'should raise an error' do
          target_set.gender = 3
          expect{ target_set.validate! }.to raise_error(ArgumentError, /gender can be 0,1 or 2/i)
        end
      end
    end

    context 'age range: ' do
      context 'with start age larger than end age' do
        it 'should raise an error' do
          target_set.age_range = [2,1]
          expect{ target_set.validate! }.to raise_error(ArgumentError, /must be lower than end/i)
        end
      end

      context 'with negative ages' do
        it 'should raise an error' do
          target_set.age_range = [-3,-1]
          expect{ target_set.validate! }.to raise_error(ArgumentError, /must be positive/i)
        end
      end

      context 'with one element' do
        it 'should raise an error' do
          target_set.age_range = [3]
          expect{ target_set.validate! }.to raise_error(ArgumentError, /start age and end age/i)
        end
      end

      context 'with more than 2 elements' do
        it 'should raise an error' do
          target_set.age_range = [1,2,3]
          expect{ target_set.validate! }.to raise_error(ArgumentError, /start age and end age/i)
        end
      end
    end
  end
end
