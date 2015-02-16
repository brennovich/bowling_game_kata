class Frame
  attr_accessor :index, :rolls

  def initialize(index)
    @index = index
    @rolls = []
  end

  def score(next_frame = nil)
    return scored if last?

    if strike?
      scored + next_frame.strike_bonus
    elsif spare?
      scored + next_frame.spare_bonus
    else
      scored
    end
  end

  def roll(pins)
    @rolls << pins
  end

  def finished?
    strike? || rolls.size == 2
  end

  def last?
    index == 9
  end

  def strike?
    rolls.first == 10
  end

  def spare?
    rolls.size == 2 && scored == 10
  end

  def scored
    rolls.reduce(:+)
  end

  def spare_bonus
    rolls.first
  end

  def strike_bonus
    return rolls[0..1].reduce(:+) if last? && strike?
    return scored + 10 if strike?

    scored
  end
end
