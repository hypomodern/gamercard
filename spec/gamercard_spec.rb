require 'spec_helper'

describe Gamercard do
  it "should be configurable" do
    Gamercard.should respond_to(:configure)
  end

  it "has a sensible default for .adapter" do
    Gamercard.adapter.should == :typhoeus
  end

  describe "#get" do
    it "is a shortcut to Client#fetch" do
      Gamercard::Client.should_receive(:new).and_return(mock(:fetch => "OK."))
      Gamercard.get("foo").should == "OK."
    end
  end
end