require "./priority-queue"

abstract class Garnet::System
  include Comparable(System)

  abstract def update(entity : Entity, delta_time : Float32)

  def priority : Int32
    0
  end

  def <=>(item)
    priority <=> item.priority
  end
end

require "./systems/lambda"
