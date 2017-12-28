require 'minitest/autorun'

class RubyTest < Minitest::Test
#   def test_rescue_inside_do_end_block
#     [1].each do |n|
#       n / 0
#     rescue
#       # rescue
#     else
#       # else
#     ensure
#       # ensure
#     end
# 
#     ruby = <<~RUBY
#       [1].each { |n|
#         n / 0
#       rescue
#         # rescue
#       else
#         # else
#       ensure
#         # ensure
#       }
#     RUBY
#     assert_raises(SyntaxError) do
#       RubyVM::InstructionSequence.compile(ruby)
#     end
#   end
# 
#   def test_top_level_constant_lookup
#     require_relative './class_constants'
#     assert_raises(NameError) do
#       Staff::ItemsController
#     end
# 
#     assert Object::ItemsController
#     assert ::ItemsController
#   end
# 
#   def test_refinements_take_place_in_string_interpolations
#     require_relative './refinements_samples'
#     assert_equal 'b', C.new.c1
#     assert_equal 'b', C.new.c2
#   end
# 
#   def test_array_prepend
#     array = [3, 4]
#     assert_equal [1, 2, 3, 4], array.unshift(1, 2)
#     assert_equal [1, 2, 3, 4], array
# 
#     array = [3, 4]
#     assert_equal [1, 2, 3, 4], array.prepend(1, 2)
#     assert_equal [1, 2, 3, 4], array
#   end
# 
#   def test_array_append
#     array = [1, 2]
#     assert_equal [1, 2, 3, 4], array.push(3, 4)
#     assert_equal [1, 2, 3, 4], array
# 
#     array = [1, 2]
#     assert_equal [1, 2, 3, 4], array.append(3, 4)
#     assert_equal [1, 2, 3, 4], array
#   end
# 
#   def test_dir_glob
#     assert_equal ['./code_a.rb'], Dir.glob('./*.rb', base: './test/dir_a')
#     assert_equal ['./code_b.rb'], Dir.glob('./*.rb', base: './test/dir_b')
#   end
# 
#   def test_dir_children_each_child
#     assert_equal ['.', '..', 'code_a.rb', 'text_a.txt'].sort, Dir.entries('./test/dir_a').sort
# 
#     assert_equal ['code_a.rb', 'text_a.txt'].sort, Dir.children('./test/dir_a').sort
# 
#     assert_instance_of Enumerator, Dir.each_child('./test/dir_a')
#     assert_equal ['code_a.rb', 'text_a.txt'].sort, Dir.each_child('./test/dir_a').to_a.sort
#   end
# 
#   def test_hash_transform_keys
#     hash = { a: 1, b: 2 }
# 
#     assert_equal(
#       { 'a' => 1, 'b' => 2 },
#       hash.transform_keys { |k| k.to_s }
#     )
#     assert_equal(
#       { 'a' => 2 },
#       hash.transform_keys { |_| 'a' }
#     )
#     assert_equal({ a: 1, b: 2 }, hash)
# 
#     assert_equal(
#       { 'a' => 1, 'b' => 2 },
#       hash.transform_keys! { |k| k.to_s }
#     )
#     assert_equal({ 'a' => 1, 'b' => 2 }, hash)
#   end
# 
#   def test_round_floor_ceil_truncate
#     assert_equal 10000000000000000000000000, (10**25).round(2)
#     assert_equal 10000000000000000000000000, (10**25).floor(2)
#     assert_equal 10000000000000000000000000, (10**25).ceil(2)
#     assert_equal 10000000000000000000000000, (10**25).truncate(2)
#   end
# 
#   def test_integer_sqrt
#     n = 10**46
#     assert_equal 100000000000000000000000, Integer.sqrt(n)
#     assert_equal 99999999999999991611392, Math.sqrt(n).to_i
# 
#     assert_equal 1, Integer.sqrt(3)
#     assert_equal 3, Integer.sqrt(9.9)
#   end
# 
#   def test_yield_self
#     assert_equal 20, 2.yield_self { |n| n * 10 }
#     assert_equal 'HELLO', 'hello'.yield_self { |s| s.upcase }
# 
#     names = ['Alice', 'Bob']
#     assert_equal '(Alice, Bob)', names.join(', ').yield_self { |s| "(#{s})" }
#   end
# 
#   def test_string_casecmp
#     assert_nil :abc.casecmp(1)
#     assert_nil :abc.casecmp?(1)
# 
#     assert_nil 'abc'.casecmp(1)
#     assert_nil 'abc'.casecmp?(1)
#   end
# 
#   def test_string_delete_prefix
#     assert_equal 'visible', 'invisible'.delete_prefix('in')
#     assert_equal 'pink', 'pink'.delete_prefix('in')
#   end
# 
#   def test_string_delete_suffix
#     assert_equal 'work', 'worked'.delete_suffix('ed')
#     assert_equal 'medical', 'medical'.delete_suffix('ed')
#   end
# 
#   def test_thread_fetch
#     Thread.current[:foo] = 'bar'
#     assert_equal 'bar', Thread.current.fetch(:foo, 'baz')
#     assert_equal 'baz', Thread.current.fetch(:hoge, 'baz')
# 
#     assert_equal 'bar', Thread.current.fetch(:foo)
#     assert_raises(KeyError) do
#       Thread.current.fetch(:hoge)
#     end
#   end
# 
#   def format_time(t)
#     t.strftime('%Y-%m-%d %H:%M:%S.%N')
#   end
# 
#   def test_time_at_3rd_argument
#     require 'time'
# 
#     t = Time.parse('2017-12-25')
#     assert_equal '2017-12-25 00:00:00.000000000', format_time(t)
#     assert_equal 1514127600, t.to_i
# 
#     t_usec = Time.at(1514127600, 1)
#     assert_equal '2017-12-25 00:00:00.000001000', format_time(t_usec)
#     t_msec = Time.at(1514127600, 1 * 1000)
#     assert_equal '2017-12-25 00:00:00.001000000', format_time(t_msec)
#     t_nsec = Time.at(1514127600, 1 / 1000.0)
#     assert_equal '2017-12-25 00:00:00.000000001', format_time(t_nsec)
# 
#     t_msec = Time.at(1514127600, 1, :millisecond)
#     assert_equal '2017-12-25 00:00:00.001000000', format_time(t_msec)
# 
#     t_usec = Time.at(1514127600, 1, :usec)
#     assert_equal '2017-12-25 00:00:00.000001000', format_time(t_usec)
#     t_usec = Time.at(1514127600, 1, :microsecond)
#     assert_equal '2017-12-25 00:00:00.000001000', format_time(t_usec)
# 
#     t_nsec = Time.at(1514127600, 1, :nsec)
#     assert_equal '2017-12-25 00:00:00.000000001', format_time(t_nsec)
#     t_nsec = Time.at(1514127600, 1, :nanosecond)
#     assert_equal '2017-12-25 00:00:00.000000001', format_time(t_nsec)
#   end
# 
#   def test_key_error
#     begin
#       h = {foo: 1, bar: 2}
#       h.fetch(:bax)
#     rescue KeyError => e
#       assert_same h, e.receiver
#       assert_equal :bax, e.key
#     end
#   end
# 
#   def test_regexp
#     text = <<-LOG
# 10:00 [INFO] Lorem ipsum dolor sit amet
# 10:10 [WARN] Lorem ipsum dolor sit amet
# 10:20 [INFO] Lorem ipsum dolor sit amet
# 10:25 [DEBUG] Lorem ipsum dolor sit amet
# 10:30 [ERROR] Lorem ipsum dolor sit amet
# 10:40 [INFO] Lorem ipsum dolor sit amet
#     LOG
#   regexp = /^(?~DEBUG|INFO)$/
#     expected = <<-LOG.lines.map(&:chomp)
# 10:10 [WARN] Lorem ipsum dolor sit amet
# 10:30 [ERROR] Lorem ipsum dolor sit amet
#     LOG
#     assert_equal expected, text.scan(regexp)
#   end
# 
#   def test_unicode_10
#     assert "A\u{1B10A}B".match?(/\p{In_Kana_Extended_A}/)
#   end
# 
#   def test_bundler
#     require 'bundler'
#     assert Bundler
#   end
# 
#   require 'set'
# 
#   def test_set_to_s
#     s1 = Set.new
#     s1 << 'tic' << 'tac'
#     assert_equal '#<Set: {"tic", "tac"}>', s1.to_s
#   end
# 
#   def test_set_triple_equals
#     assert Set[1, 2, 3].include?(2)
#     refute Set[1, 2, 3].include?(5)
# 
#     assert Set[1, 2, 3] === 2
#     refute Set[1, 2, 3] === 5
#   end
# 
#   def test_erb_result_with_hash
#     require 'erb'
#     require 'ostruct'
# 
#     template = 'Result: <%= a * b %>'
# 
#     namespace = OpenStruct.new(a: 2, b: 3)
#     assert_equal 'Result: 6', ERB.new(template).result(namespace.instance_eval { binding })
# 
#     assert_equal 'Result: 6', ERB.new(template).result_with_hash(a: 2, b: 3)
#   end
# 
#   def test_full_message
#     1 / 0
#   rescue => e
#     message = e.full_message
#     assert_match /ZeroDivisionError/, message
#     assert_match %r{divided by 0}, message
#     assert_match /from.*`test_full_message'/, message
#   end
# 
#   # any?,all?,none?,one?
#   def test_enumerable_with_pattern_args
#     arr = ['abc', 123]
#     assert arr.any? { |obj| Integer === obj }
#     refute arr.any? { |obj| Float === obj }
#     assert arr.any?(Integer)
#     refute arr.any?(Float)
# 
#     arr = ['123-4567', '789-0123']
#     assert arr.all? { |s| /\d+-\d+/ === s }
#     refute arr.all? { |s| /123-\d+/ === s }
#     assert arr.all?(/\d+-\d+/)
#     refute arr.all?(/123-\d+/)
# 
#     # none?やone?も同じような考え方で引数を渡せる
#   end
# 
#   def test_hash_slice
#     hash = { a: 'Alice', b: 'Bob', c: 'Carol' }
#     assert_equal({ a: 'Alice', c: 'Carol' }, hash.slice(:a, :c))
#   end
# 
#   def test_pp
#     respond_to?(:pp)
#   end
# 
#   def plus_or_minus(value)
#     case value
#     when 0.method(:<)
#       '+'
#     when 0.method(:>)
#       '-'
#     when 0.method(:==)
#       '0'
#     end
#   end
# 
#   def adult?(age)
#     age > 20
#   end
# 
#   def child?(age)
#     age < 20
#   end
# 
#   def adult_or_child(age)
#     case age
#     when method(:adult?).to_proc
#       '大人です'
#     when method(:child?).to_proc
#       '子どもです'
#     else
#       'はたちです'
#     end
#   end
# 
#   def hello(name)
#     "Hello, #{name}!"
#   end
# 
#   def test_method_triple_equal
#     assert_equal 'Hello, Alice!', method(:hello) === 'Alice'
# 
#     assert_equal '大人です', adult_or_child(21)
#     assert_equal '子どもです', adult_or_child(19)
#     assert_equal 'はたちです', adult_or_child(20)
#   end
# 
#   # Module#{attr,attr_accessor,attr_reader,attr_writer}
#   # Module#{define_method,alias_method,undef_method,remove_method}
#   def test_public_module_methods
#     user_class = Class.new
#     user_class.attr_accessor :name
#     user_class.define_method(:hello, -> { "Hello, I am #{name}." })
#     user = user_class.new
#     user.name = 'Alice'
#     assert_equal 'Alice', user.name
#     assert_equal 'Hello, I am Alice.', user.hello
#   end
# 
#   def test_start_with
#     s = '123abc'
#     assert s.start_with?(/\d+/)
#     refute s.start_with?(/9\d+/)
#   end
# 
#   def test_undump
#     original = "hello \n ''"
#     dumped = original.dump
#     assert_equal "\"hello \\n ''\"", dumped
#     assert_equal original, dumped.undump
#   end
# 
#   OldPoint = Struct.new(:x, :y)
#   NewPoint = Struct.new(:x, :y, keyword_init: true)
#   def test_struct_with_keyword_init
#     p1 = OldPoint.new(1, 2)
#     assert_equal 1, p1.x
#     assert_equal 2, p1.y
# 
#     p2 = NewPoint.new(y: 20, x: 10)
#     assert_equal 10, p2.x
#     assert_equal 20, p2.y
#   end
# 
#   def test_default_value_of_report_on_exception
#     assert Thread.report_on_exception
#   end
# 
#   def test_frozen_error
#     s = 'a'.freeze
#     assert_raises(FrozenError) do
#       s.upcase!
#     end
#   end
# 
#   # class Test
#   #   attr_accessor :x, :y, :z
#   #   def initialize(x, y, z)
#   #     @x = x
#   #     @y = y
#   #     binding.irb
#   #     @z = z
#   #   end
#   # end
#   # def test_binding_irb
#   #   a = Test.new(1, 2, 3)
#   # end
# 
#   require 'securerandom'
#   def test_secure_random_alphanumeric
#     assert_match /^[a-zA-Z0-9]{16}$/, SecureRandom.alphanumeric
#   end
# 
#   require "stringio"
#   def test_string_io
#     a = StringIO.new("hoge", 'r+')
#     a.write("abc", "1234")
#     assert_equal 'abc1234', a.string
#   end
# 
#   require "tempfile"
#   def test_file_io
#     Tempfile.create do |f|
#       path = f.path
#       File.open(f.path, 'w') do |f|
#         f.write 'xyz', '7890'
#       end
#       assert_equal 'xyz7890', File.read(path)
#     end
#   end

  require 'pathname'
  def test_pathname_glob
    dir = Pathname.new(File.expand_path('../', __FILE__))
    assert_equal 7, dir.glob('**/*.rb').count
  end

  # Performance of block passing using block parameters is improved by
  # lazy Proc allocation [Feature #14045]
  # https://blog.onk.ninja/2017/12/19/ruby_2_5_medama

  # Print error message in bold/underlined text if STDERR is unchanged and a tty.
  # [Feature #14140] [experimental]

  # https://techracho.bpsinc.jp/hachi8833/2017_11_20/48128
end