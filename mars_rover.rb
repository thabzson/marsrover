class MarsRover
  DIRECTIONS = %w(N E S W).freeze

  attr_reader :face, :x, :y

  def initialize(max_x, max_y)
    @x = 0
    @y = 0
    @max_x = max_x.to_i
    @max_y = max_y.to_i
  end

  def deploy(x, y, face)
    @x = x.to_i
    @y = y.to_i
    @face = face
  end

  def turn_left(step = 1)
    face_to('-', step)
  end

  def turn_right(step = 1)
    face_to('+', step)
  end

  def move_forward
    case @face
    when 'N'
      @y += 1
    when 'S'
      @y -= 1
    when 'E'
      @x += 1
    when 'W'
      @x -= 1
    end

    raise OutOfBound, 'The rover is out of space' if limit?

    [@y, @x]
  end

  def process(commands)
    commands.each_char do |character|
      case character
      when 'L' then turn_left
      when 'R' then turn_right
      when 'M' then move_forward
      end
    end

    [@x, @y, @face].join(' ')
  end

  def self.parse(string)
    commands = string.split("\n")
    rover = new(*commands.delete_at(0).split(' '))

    output = ''

    commands.each_slice(2) do |deploy_coords, instructions|
      rover.deploy(*deploy_coords.split(' '))
      output << rover.process(instructions) + "\n"
    end

    output
  end

  private

  def face_to(operator, step)
    idx = DIRECTIONS.index(@face).method(operator).call(step) % 4
    @face = DIRECTIONS[idx]
  end

  def limit?
    @x > @max_x || @y > @max_y
  end

  class OutOfBound < StandardError
  end
end
