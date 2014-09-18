require 'spec_helper'
include MeasureScaler

RSpec.describe Prefixes do
  class DummyClass; end

  before(:all) do
    @p = DummyClass.new
    @p.extend Prefixes
  end

  it 'find first symbol factor' do
    expect(@p.find_factor(Prefixes::LIST.first)).to eq(Prefixes::MIN_FACTOR)
  end

  it 'find last symbol factor' do
    expect(@p.find_factor(Prefixes::LIST.last)).to eq(Prefixes::MAX_FACTOR)
  end

  it "doesn't find factor for invalid symbol" do
    expect(@p.find_factor("X")).to be_nil
  end

  it 'find all symbol factor' do
    Prefixes::LIST.each_with_index do |symbol, i|
      factor = Prefixes::MIN_FACTOR + i*Prefixes::STEP
      expect(@p.find_factor(symbol)).to eq(factor)
    end
  end

  it "find all factor symbol" do
    f = Prefixes::MIN_FACTOR
    i = 0
    while f<=Prefixes::MAX_FACTOR
      expect(@p.find_symbol(f)).to eql(Prefixes::LIST[i])
      f+=Prefixes::STEP
      i+=1
    end
  end

  it "doesn't find symbol for invalid factor" do
    expect(@p.find_symbol(5)).to be_nil
    expect(@p.find_symbol(-30)).to be_nil
    expect(@p.find_symbol(30)).to be_nil
  end

  it "validate valid symbol" do
    expect(@p.valid?("M")).to be_truthy
    expect(@p.valid?("m")).to be_truthy
    expect(@p.valid?("")).to be_truthy
  end

  it "validate non-valid symbol" do
    expect(@p.valid?("X")).to be_falsey
    expect(@p.valid?(nil)).to be_falsey
  end

  it "get symbols list" do
    expect(@p.symbols_list).to eq(Prefixes::LIST)
  end

end