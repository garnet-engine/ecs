class Garnet::Actions::Sequence < Garnet::Actions::Interval
  def initialize(@actions : Array(Action))
    super(@actions.sum(&.duration))
    @index = 0
  end

  def done?
    @index >= @actions.size
  end

  def update(delta_time)
    return if done?
    if animation = @actions[@index]
      animation.update_wrapped(delta_time)
      @index += 1 if animation.done?
    end
  end
end
