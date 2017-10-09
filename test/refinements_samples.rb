class A
end

module B
  refine A do
    def to_s
      'b'
    end
  end
end

class C
  using B

  def initialize
    @a = A.new
  end

  def c1
    @a.to_s
  end

  def c2
    "#{@a}"
  end
end
