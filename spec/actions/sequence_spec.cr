require "spec"
require "../../src/garnet-ecs"

include Garnet

describe Actions::Sequence do
  context "before update" do
    it "should not be done yet" do
      world = Entity.new
      delay = Actions::Delay.new(1)
      kill = Actions::Kill.new(world)
      sequence = Actions::Sequence.new([ delay, kill ])
      world << sequence

      delay.done?.should eq(false)
      kill.done?.should eq(false)
      sequence.done?.should eq(false)
    end
  end

  context "partial" do
    it "should be partially done" do
      world = Entity.new
      delay = Actions::Delay.new(1)
      kill = Actions::Kill.new(world)
      sequence = Actions::Sequence.new([ delay, kill ])
      world << sequence

      world.update(1.5)

      delay.done?.should eq(true)
      kill.done?.should eq(false)
      sequence.done?.should eq(false)
    end
  end

  context "complete" do
    it "should be done" do
      world = Entity.new
      delay = Actions::Delay.new(1)
      kill = Actions::Kill.new(world)
      sequence = Actions::Sequence.new([ delay, kill ])
      world << sequence

      world.update(1)
      world.update(1)

      kill.done?.should eq(true)
      delay.done?.should eq(true)
      sequence.done?.should eq(true)
    end
  end
end
