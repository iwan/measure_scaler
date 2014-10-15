# encoding: UTF-8
require 'spec_helper'
include MeasureScaler

RSpec.describe Measure do


  context 'number' do
    let(:qty1) { 12500.34 }
    let(:unit1) { "MWh" }
    let(:prec1) { 4 } # precision
    let(:valid_measure1) { Measure.new(qty1, unit1) }
    let(:valid_measure2) { Measure.new(qty1, unit1, prec1) }
    let(:valid_measure2) { Measure.new(qty1, unit1, prec1) }

    let(:valid_measure3) { Measure.new(qty1, "€/kWh") }
    let(:valid_measure4) { Measure.new(qty1, "€/kWh", prec1) }

    it 'initialize successfully' do
      expect(valid_measure1.qty).to eq(qty1)
      expect(valid_measure1.unit).to be_an_instance_of Unit
      expect(valid_measure1.unit.prefix).to be_an_instance_of Prefix
      expect(valid_measure1.unit.prefix.symbol).to eq("M")
      expect(valid_measure1.unit.prefix.factor).to eq(6)
      expect(valid_measure1.unit.unit).to eq("Wh")
      expect(valid_measure1.unit.preunit).to be_nil
      # ...
      expect(valid_measure1.precision).to be_nil
      expect(valid_measure2.precision).to eq(prec1)
    end

    it "initialize incorrectly" do
    end

    it "scale zero" do
      Measure.new([55.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], "MWh", 4).scale
    end

    context 'without preunit' do
      it "when scaled it's always a measure" do
        expect(valid_measure1.scale).to be_an_instance_of Measure
        expect(valid_measure2.scale).to be_an_instance_of Measure
      end

      it "scale without precision" do
        scaled = valid_measure1.scale
        expect(scaled.to_s).to eq("12.50034 GWh")
      end

      it "scale with precision" do
        scaled = valid_measure2.scale
        expect(scaled.to_s).to eq("12.5 GWh")
        
        expect(Measure.new(qty1, unit1, 1).scale.to_s).to eq("10.0 GWh")
        expect(Measure.new(qty1, unit1, 2).scale.to_s).to eq("13.0 GWh")
        expect(Measure.new(qty1, unit1, 5).scale.to_s).to eq("12.5 GWh")
        expect(Measure.new(qty1, unit1, 6).scale.to_s).to eq("12.5003 GWh")
        expect(Measure.new(qty1, unit1, 7).scale.to_s).to eq("12.50034 GWh")
      end

      it "scale correctly with negative measures" do
        expect(Measure.new(-12345.678, unit1, 4).scale.to_s).to eq("-12.35 GWh")
      end
        
    end

    context 'with preunit' do
      it "when scaled it's always a measure" do
        expect(valid_measure3.scale).to be_an_instance_of Measure
      end

      it "scale without precision" do
        scaled = valid_measure3.scale
        expect(scaled.to_s).to eq("12.50034 €/Wh")
      end

      it "scale with precision" do
        scaled = valid_measure4.scale
        expect(scaled.to_s).to eq("12.5 €/Wh")
      end
    end
  end

  context 'array' do
    let(:arr1) { [12500.34, 201653.1, 5000.9] }
    let(:unit1) { "MWh" }
    let(:prec1) { 4 } # precision
    let(:valid_measure1) { Measure.new(arr1, unit1) }
    let(:valid_measure2) { Measure.new(arr1, unit1, prec1) }
    let(:valid_measure2) { Measure.new(arr1, unit1, prec1) }

    let(:valid_measure3) { Measure.new(arr1, "€/kWh") }
    let(:valid_measure4) { Measure.new(arr1, "€/kWh", prec1) }

    it 'initialize successfully' do
      expect(valid_measure1.qty).to eq(arr1)
      expect(valid_measure1.unit).to be_an_instance_of Unit
      expect(valid_measure1.unit.prefix).to be_an_instance_of Prefix
      expect(valid_measure1.unit.prefix.symbol).to eq("M")
      expect(valid_measure1.unit.prefix.factor).to eq(6)
      expect(valid_measure1.unit.unit).to eq("Wh")
      expect(valid_measure1.unit.preunit).to be_nil
      # ...
      expect(valid_measure1.precision).to be_nil
      expect(valid_measure2.precision).to eq(prec1)
    end

    it "initialize incorrectly" do
    end

    context 'without preunit' do
      it "when scaled it's always a measure" do
        expect(valid_measure1.scale).to be_an_instance_of Measure
        expect(valid_measure2.scale).to be_an_instance_of Measure
      end

      it "scale without precision" do
        scaled = valid_measure1.scale
        expect(scaled.qty).to eq([12.50034, 201.6531, 5.0009])
        expect(scaled.unit.to_s).to eq("GWh")
      end

      it "scale with precision" do
        scaled = valid_measure2.scale
        expect(scaled.qty).to eq([12.5, 201.7, 5.001])
        expect(scaled.unit.to_s).to eq("GWh")        
      end
    end

    context 'with preunit' do
      it "when scaled it's always a measure" do
        expect(valid_measure3.scale).to be_an_instance_of Measure
        expect(valid_measure4.scale).to be_an_instance_of Measure
      end

      it "scale without precision" do
        scaled = valid_measure3.scale
        expect(scaled.qty).to eq([12.50034, 201.6531, 5.0009])
        expect(scaled.unit.to_s).to eq("€/Wh")
      end

      it "scale with precision" do
        scaled = valid_measure4.scale
        expect(scaled.qty).to eq([12.5, 201.7, 5.001])
        expect(scaled.unit.to_s).to eq("€/Wh")        
      end

    end
  end
end