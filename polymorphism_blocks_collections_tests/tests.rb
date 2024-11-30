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

  private

  attr_writer :processor
end