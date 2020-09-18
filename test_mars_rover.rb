require 'minitest/autorun'
require './mars_rover'

class TestMarsRover < MiniTest::Unit::TestCase
  def setup
    @rover = MarsRover.new(5,5)
  end

  def test_turn_left
    @rover.deploy(0,0,'N')

    assert_equal 'W', @rover.turn_left
    assert_equal 'S', @rover.turn_left
    assert_equal 'E', @rover.turn_left
    assert_equal 'N', @rover.turn_left
  end

  def test_turn_right
    @rover.deploy(0,0,'N')

    assert_equal 'E', @rover.turn_right
    assert_equal 'S', @rover.turn_right
    assert_equal 'W', @rover.turn_right
    assert_equal 'N', @rover.turn_right
  end

  def test_turn_right_with_step_2
    @rover.deploy(0,0,'N')

    assert_equal 'S', @rover.turn_right(2)
    assert_equal 'N', @rover.turn_right(2)
  end

  def test_turn_left_with_step_2
    @rover.deploy(0,0,'S')

    assert_equal 'N', @rover.turn_left(2)
    assert_equal 'S', @rover.turn_left(2)
  end

  def test_limit
    @rover.deploy(5,5,'N')

    exception = assert_raises MarsRover::OutOfBound do
      @rover.move_forward
    end

    assert_equal('Rover out in space', exception.message)
  end

  def test_process_1_2
    @rover.deploy(1,2,'N')
    assert_equal '1 3 N', @rover.process('LMLMLMLMM')
  end

  def test_process_3_3
    @rover.deploy(3,3,'E')
    assert_equal '5 1 E', @rover.process('MMRMMRMRRM')
  end

  def test_parse_the_input
    assert_equal "1 3 N\n5 1 E\n", MarsRover.parse("5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM")
  end
end
