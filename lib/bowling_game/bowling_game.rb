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
      @current_frame = next_frame(@current_frame)
    else
      @current_frame
    end
  end

  def next_frame(reference = current_frame)
    return reference if @frames.last == reference

    @frames[reference.index + 1]
  end

  def score
    @score = frames.map { |frame| frame.score next_frame(frame) }.reduce(:+)
  end
end
