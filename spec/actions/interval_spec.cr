require "spec"
require "../../src/garnet-ecs"

include Garnet

class Delay < Actions::Interval
  def update(_delta_time)
  end
end

describe Actions::Interval do
  it "should not be done before update" do
    action = Delay.new(1)
    action.done?.should eq(false)
  end

  it "should not be done before reaching the given duration" do
    world = Entity.new
    action = Delay.new(1)
    world << action
    world.update(0.5f32)
    action.done?.should eq(false)
  end

  it "should be done after reaching the given duration" do
    world = Entity.new
    action = Delay.new(1)
    world << action
    world.update(1.5f32)
    action.done?.should eq(true)
  end
end
