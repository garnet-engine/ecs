require "spec"
require "../src/garnet-ecs"

include Garnet

describe Action do
  describe "#update" do
    it "should trigger update" do
      world = Entity.new
      action = Actions::Lambda.new do |delta_time|
        delta_time.should eq(0.5f32)
      end
      world << action
      world.update(0.5f32)
    end
  end

  describe "#done?" do
    it "should support done marking" do
      action = Actions::Lambda.new {}
      action.done?.should eq(false)
      action.done = true
      action.done?.should eq(true)
    end
  end
end
