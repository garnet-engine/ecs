require "spec"
require "../../src/garnet-ecs"

include Garnet

describe Actions::Kill do
  it "should not be done before update" do
    world = Entity.new
    action = Actions::Kill.new(world)
    action.done?.should eq(false)
    world.dead?.should eq(false)
  end

  it "should be done after update" do
    world = Entity.new
    action = Actions::Kill.new(world)
    world << action
    world.update(0.0000001f32)
    action.done?.should eq(true)
    world.dead?.should eq(true)
  end
end
