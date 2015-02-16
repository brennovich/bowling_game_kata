require 'forwardable'

class BowlingGame
  extend Forwardable

  attr_reader :score, :frames

  delegate roll: :current_frame

  def initialize(turns = 10)
    @frames = turns.times.map { |index| Frame.new index }
    @current_frame = frames.first
  end

  def current_frame
    if @current_frame.finished?
      @current_frame = @frames[@current_frame.index + 1]
    else
      @current_frame
    end
  end

  def previous_frame(reference = current_frame)
    return if reference == @frames.first

    @frames[reference.index - 1]
  end

  def score
    @score = frames.map { |frame| frame.score previous_frame(frame) }.reduce(:+)
  end
end
