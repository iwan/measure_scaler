require 'spec_helper'
include MeasureScaler

describe QuantityMethods do

  context 'number' do
    it "propose a scale" do
      expect(2.5.scaling_proposal).to eq(0)
      expect(25.scaling_proposal).to eq(0)
      expect(250.scaling_proposal).to eq(0)
      expect(999.99.scaling_proposal).to eq(0)
      expect(1000.scaling_proposal).to eq(3)
      expect(2500.scaling_proposal).to eq(3)
      expect(2500000.scaling_proposal).to eq(6)

      expect(0.25.scaling_proposal).to eq(-3)
      expect(0.025.scaling_proposal).to eq(-3)
      expect(0.0025.scaling_proposal).to eq(-3)
      expect(0.00025.scaling_proposal).to eq(-6)
    end

    it "scale" do
      expect(2500.scale(-3)).to eq(2500000)
      expect(2500.scale(0)).to eq(2500)
      expect(2500.scale(3)).to eq(2.5)

      expect(0.scale(3)).to eq(0)
    end
  end

  context 'array' do
    it "propose a scale" do
      expect([0.25, 1200, 34, 34214, 900, 899000].scaling_proposal).to eq(3)
      expect([0.25, 1200, 34, 34214, 900].scaling_proposal).to eq(0)
      expect([0.25, 1200, 34, 34214, 900, 0.01].scaling_proposal).to eq(0)
      expect([0.25, 0.034, 0.9, 0.01].scaling_proposal).to eq(-3)
    end

    it "scale" do
      expect([0.25, 1200, 34, 34214, 900, 899000].scale(0)).to eq([0.25, 1200, 34, 34214, 900, 899000])
      expect([0.25, 1200, 34, 34214, 900, 899000].scale(3)).to eq([0.00025, 1.2, 0.034, 34.214, 0.9, 899])
    end
  end

end