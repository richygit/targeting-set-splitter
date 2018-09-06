require_relative '../targeting_set_splitter'
require 'rspec'

RSpec.describe TargetingSetSplitter do
  describe '#split' do
    #it 'should return the target set split into different sets' do
      #target = TargetSet.new(['hk', 'jp'], ['desktop', 'mobile', 'external'], 0, 13..30)
      #result_set = [
        #TargetSet.new(['hk'], ['desktop'], 0, 13..20),
        #TargetSet.new(['hk'], ['desktop'], 0, 21..30),
        #TargetSet.new(['hk'], ['mobile'], 0, 13..20),
        #TargetSet.new(['hk'], ['mobile'], 0, 21..30),
        #TargetSet.new(['hk'], ['external'], 0, 13..20),
        #TargetSet.new(['hk'], ['external'], 0, 21..30),
        #TargetSet.new(['jp'], ['desktop'], 0, 13..20),
        #TargetSet.new(['jp'], ['desktop'], 0, 21..30),
        #TargetSet.new(['jp'], ['mobile'], 0, 13..20),
        #TargetSet.new(['jp'], ['mobile'], 0, 21..30),
        #TargetSet.new(['jp'], ['external'], 0, 13..20),
        #TargetSet.new(['jp'], ['external'], 0, 21..30)
      #].to_set
      #expect(subject.split(target)).to eq(result_set)
    #end

    it "should create sets for both genders when gender is '2'" do
    end

    it 'should split countries' do
      target = TargetSet.new(['hk', 'jp'], ['desktop'], 0, 11..20)
      result_set = [
        TargetSet.new(['jp'], ['desktop'], 0, 11..20),
        TargetSet.new(['hk'], ['desktop'], 0, 11..20)
      ].to_set
      expect(subject.split(target)).to match_array(result_set)
    end
  end
end
