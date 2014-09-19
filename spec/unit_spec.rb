# encoding: UTF-8
require 'spec_helper'
include MeasureScaler

RSpec.describe Unit do
  let(:valid_unit_1) { Unit.new("MWh") }
  let(:valid_unit_2) { Unit.new("€/MWh") }
  let(:valid_unit_3) { Unit.new(prefix: "M", preunit: "€/", unit: "Wh", direction: -1) }
  let(:invalid_unit_1) { Unit.new("AAA") }
  before do
    PatternDefinitions.clear
    PatternDefinitions.config do
      add /^(€\/)(.?)(Wh)$/
      add /^(.?)(Wh)$/
    end

  end

  it 'initialize successfully' do
    expect(valid_unit_1).to               be_an_instance_of Unit
    expect(valid_unit_1.prefix).to        be_an_instance_of Prefix
    expect(valid_unit_1.prefix.symbol).to eq("M")
    expect(valid_unit_1.preunit).to       be_nil
    expect(valid_unit_1.unit).to          eq("Wh")
    expect(valid_unit_1.direction).to     eq(1)

    expect(valid_unit_2).to               be_an_instance_of Unit
    expect(valid_unit_2.prefix).to        be_an_instance_of Prefix
    expect(valid_unit_2.prefix.symbol).to eq("M")
    expect(valid_unit_2.preunit).to       eq("€/")
    expect(valid_unit_2.unit).to          eq("Wh")
    expect(valid_unit_2.direction).to     eq(-1)

    expect(valid_unit_3).to               be_an_instance_of Unit
    expect(valid_unit_3.prefix).to        be_an_instance_of Prefix
    expect(valid_unit_3.prefix.symbol).to eq("M")
    expect(valid_unit_3.preunit).to       eq("€/")
    expect(valid_unit_3.unit).to          eq("Wh")
    expect(valid_unit_3.direction).to     eq(-1)
  end

  it "fail init" do
    expect{ Unit.new(2)}.to raise_error
    expect(invalid_unit_1).to               be_an_instance_of Unit
    expect(invalid_unit_1.prefix).to        be_nil
    expect(invalid_unit_1.preunit).to       be_nil
    expect(invalid_unit_1.unit).to          be_nil
    expect(invalid_unit_1.direction).to     eq(1)
  end

  it "does find pattern" do
    expect(valid_unit_1.pattern_found?).to be_truthy
  end

  it "doesn't find pattern" do
    expect(invalid_unit_1.pattern_found?).to be_falsey
  end

  it "scale correctly" do
    def_order, new_unit = valid_unit_1.scale(3)
    expect(def_order).to eq(3)
    expect(new_unit).to be_an_instance_of Unit
    expect(new_unit.prefix).not_to eq(valid_unit_1.prefix)
    expect(new_unit.preunit).to eq(valid_unit_1.preunit)
    expect(new_unit.unit).to eq(valid_unit_1.unit)
    expect(new_unit.direction).to eq(valid_unit_1.direction)

    def_order, new_unit = valid_unit_2.scale(3)
    expect(def_order).to eq(3)
    expect(new_unit).to be_an_instance_of Unit
    expect(new_unit.prefix).not_to eq(valid_unit_2.prefix)
    expect(new_unit.preunit).to eq(valid_unit_2.preunit)
    expect(new_unit.unit).to eq(valid_unit_2.unit)
    expect(new_unit.direction).to eq(valid_unit_2.direction)

  end

end