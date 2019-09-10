class Garnet::Entity
  include Indexable(Entity)

  getter components = {} of Component.class => Component
  getter children = [] of Entity
  getter actions = [] of Action
  getter systems = [] of System
  property? dead = false

  # Components
  def <<(component : Component)
    components[component.class] = component
  end

  def [](component : Component.class)
    components[component]
  end

  def []?(component : Component.class)
    components[component]?
  end

  def delete(component : Component)
    components.delete(component.class)
  end

  def delete(component : Component.class)
    components.delete(component)
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

  def all_with_component(component : Component.class)
    children.select { |e| e[component]? }
  end

  def kill!
    @dead = true
  end

  def update(delta_time : Float32)
    children.each &.update(delta_time)
    children.reject! &.dead?

    systems.each &.update(self, delta_time)

    actions.each &.update_wrapped(delta_time)
    actions.reject! &.done?
  end
end
