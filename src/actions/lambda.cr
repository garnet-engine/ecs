class Garnet::Actions::Lambda < Garnet::Action
  property? done : Bool = false

  def initialize (&block : Float32 ->)
    @block = block
  end

  def update(delta_time)
    @block.call(delta_time)
  end

  def update_wrapped(delta_time : Float32)
    return if done?
    update(delta_time)
  end
end
