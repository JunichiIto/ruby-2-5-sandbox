require 'minitest/autorun'

class RubyTest < Minitest::Test
  def test_rescue_inside_do_end_block
    [1].each do |n|
      n / 0
    rescue
      # rescue
    else
      # else
    ensure
      # ensure
    end

    ruby = <<~RUBY
      [1].each { |n|
        n / 0
      rescue
        # rescue
      else
        # else
      ensure
        # ensure
      }
    RUBY
    assert_raises(SyntaxError) do
      RubyVM::InstructionSequence.compile(ruby)
    end
  end

  def test_top_level_constant_lookup
    require_relative './class_constants'
    assert_raises(NameError) do
      Staff::ItemsController
    end

    assert Object::ItemsController
    assert ::ItemsController
  end

  def test_refinements_take_place_in_string_interpolations
    require_relative './refinements_samples'
    assert_equal 'b', C.new.c1
    assert_equal 'b', C.new.c2
  end

  def test_array_prepend
    array = [3, 4]
    assert_equal [1, 2, 3, 4], array.unshift(1, 2)
    assert_equal [1, 2, 3, 4], array

    array = [3, 4]
    assert_equal [1, 2, 3, 4], array.prepend(1, 2)
    assert_equal [1, 2, 3, 4], array
  end

  def test_array_append
    array = [1, 2]
    assert_equal [1, 2, 3, 4], array.push(3, 4)
    assert_equal [1, 2, 3, 4], array

    array = [1, 2]
    assert_equal [1, 2, 3, 4], array.append(3, 4)
    assert_equal [1, 2, 3, 4], array
  end

  def test_dir_glob
    assert_equal ['./code_a.rb'], Dir.glob('./*.rb', base: './test/dir_a')
    assert_equal ['./code_b.rb'], Dir.glob('./*.rb', base: './test/dir_b')
  end

  def test_dir_children_each_child
    assert_equal ['.', '..', 'code_a.rb', 'text_a.txt'], Dir.entries('./test/dir_a')

    assert_equal ['code_a.rb', 'text_a.txt'], Dir.children('./test/dir_a')

    assert_instance_of Enumerator, Dir.each_child('./test/dir_a')
    assert_equal ['code_a.rb', 'text_a.txt'], Dir.each_child('./test/dir_a').to_a
  end

  def test_hash_transform_keys
    hash = { a: 1, b: 2 }

    assert_equal(
      { 'a' => 1, 'b' => 2 },
      hash.transform_keys { |k| k.to_s }
    )
    assert_equal(
      { 'a' => 2 },
      hash.transform_keys { |_| 'a' }
    )
    assert_equal({ a: 1, b: 2 }, hash)

    assert_equal(
      { 'a' => 1, 'b' => 2 },
      hash.transform_keys! { |k| k.to_s }
    )
    assert_equal({ 'a' => 1, 'b' => 2 }, hash)
  end

  def test_integer_sqrt
    assert_equal 3, Integer.sqrt(9)
    assert_equal 1, Integer.sqrt(2)

    assert_equal 1.414, Math.sqrt(2).round(3)
  end

  def test_yield_self
    assert_equal 20, 2.yield_self { |n| n * 10 }
    assert_equal 'HELLO', 'hello'.yield_self { |s| s.upcase }

    names = [nil, nil]
    assert_equal '', names.compact.join(', ').yield_self { |s| s.empty? ? s : "(#{s})"}

    names = ['Alice', 'Bob']
    assert_equal '(Alice, Bob)', names.compact.join(', ').yield_self { |s| s.empty? ? s : "(#{s})"}
  end

  def test_string_casecmp
    assert_nil :abc.casecmp(1)
    assert_nil :abc.casecmp?(1)

    assert_nil 'abc'.casecmp(1)
    assert_nil 'abc'.casecmp?(1)
  end

  def test_string_delete_prefix
    assert_equal 'visible', 'invisible'.delete_prefix('in')
    assert_equal 'pink', 'pink'.delete_prefix('in')
  end

  def test_string_delete_suffix
    assert_equal 'work', 'worked'.delete_suffix('ed')
    assert_equal 'medical', 'medical'.delete_suffix('ed')
  end

  def test_thread_fetch
    Thread.current[:foo] = 'bar'
    assert_equal 'bar', Thread.current.fetch(:foo, 'baz')
    assert_equal 'baz', Thread.current.fetch(:hoge, 'baz')

    # 第2引数を指定しない場合はキーが見つからないとエラーになる
    assert_equal 'bar', Thread.current.fetch(:foo)
    assert_raises(KeyError) do
      Thread.current.fetch(:hoge)
    end
  end

  def format_time(t)
    t.strftime('%Y-%m-%d %H:%M:%S.%N')
  end

  def test_time_at_3rd_argument
    require 'time'

    t = Time.parse('2017-12-25')
    assert_equal '2017-12-25 00:00:00.000000000', format_time(t)
    assert_equal 1514127600, t.to_i

    t_usec = Time.at(1514127600, 1)
    assert_equal '2017-12-25 00:00:00.000001000', format_time(t_usec)
    t_msec = Time.at(1514127600, 1 * 1000)
    assert_equal '2017-12-25 00:00:00.001000000', format_time(t_msec)
    t_nsec = Time.at(1514127600, 1 / 1000.0)
    assert_equal '2017-12-25 00:00:00.000000001', format_time(t_nsec)

    t_msec = Time.at(1514127600, 1, :millisecond)
    assert_equal '2017-12-25 00:00:00.001000000', format_time(t_msec)

    t_usec = Time.at(1514127600, 1, :usec)
    assert_equal '2017-12-25 00:00:00.000001000', format_time(t_usec)
    t_usec = Time.at(1514127600, 1, :microsecond)
    assert_equal '2017-12-25 00:00:00.000001000', format_time(t_usec)

    t_nsec = Time.at(1514127600, 1, :nsec)
    assert_equal '2017-12-25 00:00:00.000000001', format_time(t_nsec)
    t_nsec = Time.at(1514127600, 1, :nanosecond)
    assert_equal '2017-12-25 00:00:00.000000001', format_time(t_nsec)
  end

  def test_key_error
    begin
      h = {foo: 1, bar: 2}
      h.fetch(:bax)
    rescue KeyError => e
      assert_same h, e.receiver
      assert_equal :bax, e.key
    end
  end

  def test_regexp
    text = <<-LOG
10:00 [INFO] Lorem ipsum dolor sit amet
10:10 [WARN] Lorem ipsum dolor sit amet
10:20 [INFO] Lorem ipsum dolor sit amet
10:25 [DEBUG] Lorem ipsum dolor sit amet
10:30 [ERROR] Lorem ipsum dolor sit amet
10:40 [INFO] Lorem ipsum dolor sit amet
    LOG
  regexp = /^(?~DEBUG|INFO)$/
    expected = <<-LOG.lines.map(&:chomp)
10:10 [WARN] Lorem ipsum dolor sit amet
10:30 [ERROR] Lorem ipsum dolor sit amet
    LOG
    assert_equal expected, text.scan(regexp)
  end

  def test_unicode_10
    assert "A\u{1B10A}B".match?(/\p{In_Kana_Extended_A}/)
  end

  def test_bundler
    require 'bundler'
    assert Bundler
  end

  require 'set'

  def test_set_to_s
    s1 = Set.new
    s1 << 'tic' << 'tac'
    assert_equal '#<Set: {"tic", "tac"}>', s1.to_s
  end

  def test_set_triple_equals
    assert Set[1, 2, 3].include?(2)
    refute Set[1, 2, 3].include?(5)

    assert Set[1, 2, 3] === 2
    refute Set[1, 2, 3] === 5
  end
end