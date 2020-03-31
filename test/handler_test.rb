require_relative '../handler.rb'
require 'test/unit'


class TestHandler < Test::Unit::TestCase
  def test_happy_path()
    response = to_upper_case(event: {"body": "Hello, World!"}, context: {})
    assert_equal 200, response[:statusCode]
    assert_match /HELLO/, response[:body]
  end

  def test_sad_path()
    response = to_upper_case(event: nil, context: {})
    assert_equal 400, response[:statusCode]
    assert_match /please POST/, response[:body]
  end
end