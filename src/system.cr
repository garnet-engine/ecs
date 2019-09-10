abstract class Garnet::System
  abstract def update(entity : Entity, delta_time : Float32)
end

require "./systems/lambda"
