class Foo
  

  def bar(*arg)
    puts arg.size
    puts arg.class
    puts arg[0].class
  end
end


Foo.new.bar(a: 1, b: 2)