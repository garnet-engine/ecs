require "spec"
require "../src/garnet-ecs"

include Garnet

describe System do
  describe "#update(entity, delta_time)" do
    it "should trigger update" do
      world = Entity.new
      sys = Systems::Lambda.new do |entity, delta_time|
        delta_time.should eq(0.5f32)
        entity.should eq(world)
      end
      sys.update(world, 0.5f32)
    end
  end
end
