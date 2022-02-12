require "./priority-queue"
require "./entity"

abstract class Garnet::System
  include Comparable(System)

  property priority : Int32 = 0

  abstract def update(entity : Entity, delta_time : Float32)

  def <=>(item)
    priority <=> item.priority
  end
end

require "./systems/lambda"
