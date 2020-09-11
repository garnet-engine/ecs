class Garnet::Systems::Lambda < Garnet::System
  property priority : Int32

  def initialize(&block : (Entity, Float32) ->)
    @priority = 0
    @block = block
  end

  def initialize(@priority : Int, &block : (Entity, Float32) ->)
    @block = block
  end

  def update(entity, delta_time)
    @block.call(entity, delta_time)
  end
end
