# encoding: UTF-8

module MeasureScaler
  PatternDefinitions.config do
    add /^(€\/)(.?)(Wh)$/
    add /^(.?)(Wh)$/
  end
end