require 'test/unit'

require 'util/rangehash'

class TestRangeHash < Test::Unit::TestCase
  def test_construction_from_hash
    hash = { 0..2 => :foo, 3..5 => :bar }
    r = RangeHash.new(hash)
    assert_not_nil(r)
    assert_equal(hash.to_s, r.to_s)
  end

  def test_get_value_for_key_in_a_range
    hash = { 0..2 => :foo, 3..5 => :bar }
    r = RangeHash.new(hash)
    assert_equal(:foo, r[1])
    assert_equal(:bar, r[4])
  end
  
  def test_with_keys_that_have_excluded_endpoint
    hash = { 0..2 => :foo, 3...5 => :bar, 5..10 => :baz }
    r = RangeHash.new(hash)
    assert_equal(:baz, r[5])
  end

  def test_default_value
    hash = { 0..2 => :foo, 3..5 => :bar }
    default_value = :quux
    r = RangeHash.new(hash, default_value)
    assert_equal(:quux, r[4568])
  end
  
  def test_bare_number_as_key
    hash = { 0..2 => :foo, 3 => :bar, 4..6 => :baz}
    r = RangeHash.new(hash)
    assert_equal(:bar, r[3])
  end
end
