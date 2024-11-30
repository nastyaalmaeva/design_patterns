require 'minitest/autorun'
require './array_processor.rb'

class Tests < Minitest::Test
  attr_reader :processor

  def setup
    @processor = ArrayProcessor.new([1, 5, 2, 2, -7, 4])
  end

  # Тест для метода any?
  def test_any_positive
    assert_equal true, processor.any? { |x| x > 0 }
  end

  def test_any_negative
    assert_equal true, processor.any? { |x| x < 0 }
  end

  def test_any_none_match
    assert_equal false, processor.any? { |x| x > 100 }
  end

  # Тесты для метода find_all
  def test_find_all_even
    assert_equal [2, 2, 4], processor.find_all { |x| x.even? }
  end

  def test_find_all_positive
    assert_equal [1, 5, 2, 2, 4], processor.find_all { |x| x > 0 }
  end

  # Тесты для метода find_index
  def test_find_index_first_even
    assert_equal 2, processor.find_index { |x| x.even? }
  end

  def test_find_index_first_negative
    assert_equal 4, processor.find_index { |x| x < 0 }
  end

  def test_find_index_none_match
    assert_nil processor.find_index { |x| x > 100 }
  end

  # Тесты для метода min_max
  def test_min_max_absolute
    assert_equal [1, -7], processor.min_max { |a, b| a.abs <=> b.abs }
  end

  def test_min_max_natural_order
    assert_equal [-7, 5], processor.min_max { |a, b| a <=> b }
  end

  private

  attr_writer :processor
end
