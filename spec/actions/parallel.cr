require "spec"
require "../../src/garnet-ecs"

include Garnet

describe Actions::Parallel do
  context "before update" do
    it "should not be done yet" do
      world = Entity.new
      kill = Actions::Kill.new(world)
      delay = Actions::Delay.new(1)
      parallel = Actions::Parallel.new([ kill, delay ])
      world << parallel

      kill.done?.should eq(false)
      delay.done?.should eq(false)
      parallel.done?.should eq(false)
    end
  end

  context "partial" do
    it "should be partially done" do
      world = Entity.new
      kill = Actions::Kill.new(world)
      delay = Actions::Delay.new(1)
      parallel = Actions::Parallel.new([ kill, delay ])
      world << parallel

      world.update(0.5)

      kill.done?.should eq(true)
      delay.done?.should eq(false)
      parallel.done?.should eq(false)
    end
  end

  context "complete" do
    it "should be done" do
      world = Entity.new
      kill = Actions::Kill.new(world)
      delay = Actions::Delay.new(1)
      parallel = Actions::Parallel.new([ kill, delay ])
      world << parallel

      world.update(1.5)

      kill.done?.should eq(true)
      delay.done?.should eq(true)
      parallel.done?.should eq(true)
    end
  end
end
