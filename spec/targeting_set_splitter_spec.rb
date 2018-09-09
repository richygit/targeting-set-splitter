require_relative '../targeting_set_splitter'
require 'rspec'

RSpec.describe TargetingSetSplitter do
  describe '#split' do
    it "should create sets for both genders when gender is '2'" do
    end

    it 'should split countries' do
      target = TargetSet.new(['hk', 'jp'], ['desktop'], 0, [11,20])
      result_set = [
        TargetSet.new(['jp'], ['desktop'], 0, [11,20]),
        TargetSet.new(['hk'], ['desktop'], 0, [11,20])
      ]
      expect(subject.split(target)).to match_array(result_set)
    end

    it 'should split placements' do
      target = TargetSet.new(['hk'], ['desktop', 'mobile'], 0, [11,20])
      result_set = [
        TargetSet.new(['hk'], ['desktop'], 0, [11,20]),
        TargetSet.new(['hk'], ['mobile'], 0, [11,20])
      ]
      expect(subject.split(target)).to match_array(result_set)
    end

    it 'should split gender' do
      target = TargetSet.new(['hk'], ['desktop'], 2, [11,20])
      result_set = [
        TargetSet.new(['hk'], ['desktop'], 0, [11,20]),
        TargetSet.new(['hk'], ['desktop'], 1, [11,20])
      ]
      expect(subject.split(target)).to match_array(result_set)

      target = TargetSet.new(['hk'], ['desktop'], 0, [11,20])
      result_set = [
        TargetSet.new(['hk'], ['desktop'], 0, [11,20])
      ]
      expect(subject.split(target)).to match_array(result_set)
    end

    it 'should split ages' do
      target = TargetSet.new(['hk'], ['desktop'], 0, [11,40])
      result_set = [
        TargetSet.new(['hk'], ['desktop'], 0, [11,20]),
        TargetSet.new(['hk'], ['desktop'], 0, [21,30]),
        TargetSet.new(['hk'], ['desktop'], 0, [31,40])
      ]
      expect(subject.split(target)).to match_array(result_set)
    end

  end
end
