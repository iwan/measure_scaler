require 'spec_helper'
include MeasureScaler

RSpec.describe Prefix do
  let(:valid_prefix) { Prefix.new("M") }

  it 'initialize successfully' do
    expect(valid_prefix).to be_an_instance_of Prefix
    expect(valid_prefix.symbol).to eq("M")
    expect(valid_prefix.factor).to eq(6)
  end

  it "initialize incorrectly" do
    expect{Prefix.new("X")}.to raise_error(MeasureScaler::PrefixError)
    expect{Prefix.new}.to raise_error
  end

  it "scale correctly" do
    expect(valid_prefix.scale(0)).to eq([0, "M"])
    expect(valid_prefix.scale(1)).to eq([0, "M"])
    expect(valid_prefix.scale(2)).to eq([3, "G"])
    expect(valid_prefix.scale(3)).to eq([3, "G"])
    expect(valid_prefix.scale(30)).to eq([18, "Y"])

    expect(valid_prefix.scale(-1)).to eq([0, "M"])
    expect(valid_prefix.scale(-2)).to eq([-3, "k"])
    expect(valid_prefix.scale(-3)).to eq([-3, "k"])
    expect(valid_prefix.scale(-40)).to eq([-30, "y"])
  end

  it "scale incorrectly" do
    
  end

  it "convert to string" do
    expect(valid_prefix.to_s).to eq("M")
  end


end