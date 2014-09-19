# encoding: UTF-8

require 'spec_helper'
include MeasureScaler

RSpec.describe PatternDefinitions do


  it 'initialize successfully' do
    expect(PatternDefinitions.def_list).to be_an_instance_of Array

    PatternDefinitions.clear
    expect(PatternDefinitions.def_list.size).to eq(0)

    PatternDefinitions.config do
      add /^(€\/)(.?)(Wh)$/
      add /^(.?)(Wh)$/
    end

    expect(PatternDefinitions.def_list.size).to eq(2)

    PatternDefinitions.config do
      add /^(€\/)(.?)(Wh)$/ # <- already present
      add /^(.?)(W)$/ #       <- new entry
    end
    expect(PatternDefinitions.def_list.size).to eq(3)

    PatternDefinitions.clear
    expect(PatternDefinitions.def_list.size).to eq(0)
  end
end