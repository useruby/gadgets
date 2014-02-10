require 'spec_helper'

describe Gadget do
  describe '.search' do
    before :each do
      FactoryGirl.create :gadget, name: 'Leica M2'
      FactoryGirl.create :gadget, name: 'Canon 5D Mark II'
      FactoryGirl.create :gadget, name: 'Nikon D800'
      FactoryGirl.create :gadget, name: 'Leica M9'
    end

    it 'should return list of gadgets with name Leica M2' do
      results = Gadget.search 'Leica M2'
      expect(results.size).to eq 1
      expect(results.first.name).to eq 'Leica M2'
    end

    it 'should return list of gadgets with name begin with Leica' do
      results = Gadget.search 'Leica'
      expect(results.size).to eq 2
    
      results.each do |gadget|
        expect(gadget.name).to be_start_with 'Leica'
      end
    end

    it 'should return empty result for request FED' do
      results = Gadget.search 'FED'
      expect(results).to be_empty
    end
  end
end
