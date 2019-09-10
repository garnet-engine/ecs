class Garnet::Systems::Lambda < Garnet::System
  def initialize (&block : (Entity, Float32) ->)
    @block = block
  end

  def update(entity, delta_time)
    @block.call(entity, delta_time)
  end
end
