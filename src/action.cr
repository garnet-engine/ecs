abstract class Garnet::Action
  abstract def update(delta_time : Float32)
  abstract def update_wrapped(delta_time : Float32)
  abstract def done? : Bool

  def duration
    0_f32
  end

  def elapsed
    0_f32
  end
end

require "./actions/instant"
require "./actions/interval"
require "./actions/delay"
require "./actions/kill"
require "./actions/lambda"
require "./actions/parallel"
require "./actions/sequence"
