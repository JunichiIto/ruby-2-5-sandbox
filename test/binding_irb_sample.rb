class Test
  attr_accessor :x, :y, :z
  def initialize(x, y, z)
    @x = x
    @y = y
    binding.irb
    @z = z
  end
end

Test.new(1, 2, 3)
