require_relative '../targeting_set_splitter'
require 'rspec'

RSpec.describe TargetingSetSplitter do
  describe '#split' do
    it 'should return the target set split into different sets' do
      target = TargetSet.new(['hk', 'jp'], ['desktop', 'mobile', 'external'], 0, [13,30])
      result_set = [
        TargetSet.new(['hk'], ['desktop'], 0, [13,20]),
        TargetSet.new(['hk'], ['desktop'], 0, [21,30]),
        TargetSet.new(['hk'], ['mobile'], 0, [13,20]),
        TargetSet.new(['hk'], ['mobile'], 0, [21,30]),
        TargetSet.new(['hk'], ['external'], 0, [13,20]),
        TargetSet.new(['hk'], ['external'], 0, [21,30]),
        TargetSet.new(['jp'], ['desktop'], 0, [13,20]),
        TargetSet.new(['jp'], ['desktop'], 0, [21,30]),
        TargetSet.new(['jp'], ['mobile'], 0, [13,20]),
        TargetSet.new(['jp'], ['mobile'], 0, [21,30]),
        TargetSet.new(['jp'], ['external'], 0, [13,20]),
        TargetSet.new(['jp'], ['external'], 0, [21,30])
      ].to_set
      expect(subject.split(target)).to match_array(result_set)
    end

    it "should create sets for both genders when gender is '2'" do
      target = build(:target_set, gender: 2)
      result_set = [
        build(:target_set, gender: 0),
        build(:target_set, gender: 1)
      ]
      expect(subject.split(target)).to match_array(result_set)
    end

    it 'should split countries' do
      target = build(:target_set, countries: ['hk', 'jp'])
      result_set = [
        build(:target_set, countries: ['jp']),
        build(:target_set)
      ]
      expect(subject.split(target)).to match_array(result_set)
    end

    it 'should split placements' do
      target = build(:target_set, placements: ['desktop', 'mobile'])
      result_set = [
        build(:target_set),
        build(:target_set, placements: ['mobile'])
      ]
      expect(subject.split(target)).to match_array(result_set)
    end

    it 'should split gender' do
      target = build(:target_set, gender: 2)
      result_set = [
        build(:target_set),
        build(:target_set, gender: 1)
      ]
      expect(subject.split(target)).to match_array(result_set)
    end

    it 'should split ages' do
      target = build(:target_set, age_range: [11,40])
      result_set = [
        build(:target_set),
        build(:target_set, age_range: [21,30]),
        build(:target_set, age_range: [31,40])
      ]
      expect(subject.split(target)).to match_array(result_set)
    end

    it 'should validate the target set' do
      target = build(:target_set, age_range: [-11,40])
      expect{ subject.split(target) }.to raise_error(ArgumentError)
    end

  end
end
