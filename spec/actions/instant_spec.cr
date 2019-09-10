require "spec"
require "../../src/garnet-ecs"

include Garnet

class Instant < Actions::Instant
  def update(_delta_time)
  end
end

describe Actions::Instant do
  it "should not be done before update" do
    action = Instant.new
    action.done?.should eq(false)
  end

  it "should be done after update" do
    world = Entity.new
    action = Instant.new
    world << action
    world.update(0.0000001f32)
    action.done?.should eq(true)
  end
end
