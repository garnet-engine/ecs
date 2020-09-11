require "./priority-queue"
require "./action"
require "./component"
require "./system"

class Garnet::Entity
  include Indexable(Entity)

  getter components = {} of Symbol => Component
  getter children = [] of Entity
  getter actions = [] of Action
  getter systems = PriorityQueue(System).new
  property? dead = false

  # Components
  def <<(component : Component)
    components[component.class.to_sym] = component
  end

  # Actions
  def <<(action : Action)
    actions << action
  end

  def delete(action : Action)
    actions.delete(action)
  end

  # Systems
  def <<(sys : System)
    systems << sys
  end

  def delete(sys : System)
    systems.delete(sys)
  end

  # Children
  def <<(entity : Entity)
    children << entity
  end

  def delete(entity : Entity)
    children.delete(entity)
  end

  def unsafe_fetch(index : Int)
    children[index]
  end

  def size
    children.size
  end

  def kill!
    @dead = true
  end

  def update(delta_time : Float32)
    children.each &.update(delta_time)
    children.reject! &.dead?

    actions.each &.update_wrapped(delta_time)
    actions.reject! &.done?

    systems.each &.update(self, delta_time)
  end
end
