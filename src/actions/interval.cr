require "../action"

abstract class Garnet::Actions::Interval < Garnet::Action
  getter duration : Float32
  getter elapsed : Float32 = 0_f32

  def initialize(@duration : Float32)
  end

  def start
  end

  def done? : Bool
    @elapsed >= @duration
  end

  abstract def update(delta_time)

  def update_wrapped(delta_time)
    start if @elapsed == 0_f32
    return if done?
    update(delta_time)
    @elapsed += delta_time
  end
end
