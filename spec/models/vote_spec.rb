require 'rails_helper'

describe Vote do
  describe "validations" do
    
    describe "value -1 validation" do
      it "accepts -1 as a valid value" do
        vote = Vote.new(value: -1)
        expect(vote.save).to be_truthy
      end
    end

    describe "value 1 validation" do
      it "accepts 1 as a valid value" do
        vote = Vote.new(value: 1)
        expect(vote.save).to be_truthy
      end
    end

    describe "non-valid validation" do
      it "all values other than 1 and -1 are invalid" do
        vote = Vote.new(value: 3)
        expect(vote.save).to be_falsey
      end
    end
  end
end