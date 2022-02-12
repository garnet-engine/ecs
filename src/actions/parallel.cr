require "./interval"

class Garnet::Actions::Parallel < Garnet::Actions::Interval
  def initialize(@actions : Array(Action))
    super(@actions.map(&.duration).max)
  end

  def update(delta_time)
    @actions.each &.update_wrapped(delta_time)
  end
end
