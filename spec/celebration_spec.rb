require_relative 'spec_helper'

describe CR::Celebration do
  describe '#==' do
    let(:c) { described_class.new('title') }

    describe 'same content' do
      let(:c2) { described_class.new('title') }

      it 'is equal' do
        expect(c).to eq c2
      end
    end

    describe 'different content' do
      let(:c2) { described_class.new('another title') }

      it 'is different' do
        expect(c).not_to eq c2
      end
    end
  end

  describe '#change' do
    let(:c) { described_class.new('title') }

    it 'produces a new instance' do
      c2 = c.change rank: CR::Ranks::SOLEMNITY_GENERAL
      expect(c2).not_to be c
    end

    it 'sets specified properties' do
      c2 = c.change rank: CR::Ranks::SOLEMNITY_GENERAL
      expect(c2.rank).not_to eq c.rank
      expect(c2.rank).to be CR::Ranks::SOLEMNITY_GENERAL
    end

    it 'copies the rest' do
      c2 = c.change rank: CR::Ranks::SOLEMNITY_GENERAL
      expect(c2.title).to be c.title # reference copying is no problem, Celebrations are immutable
    end
  end
end
