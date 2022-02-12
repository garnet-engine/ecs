require "spec"
require "../src/garnet-ecs"

include Garnet

struct TestComponent < Component
end
struct TestComponentB < Component
  getter :b
  def initialize(@b : String)
  end
end

describe Entity do
  context "components" do
    describe "#[](component)" do
      it "should find present component" do
        entity = Entity.new
        component = TestComponent.new
        entity << component
        entity[TestComponent].should eq(component)
      end

      it "should differentiate similarly derived components" do
        entity = Entity.new
        a = TestComponent.new
        b = TestComponentB.new "b"
        entity << a
        entity << b
        entity[TestComponent]?.should eq(a)
        entity[TestComponentB]?.should eq(b)

        if foo = entity[TestComponentB]?
          foo.b.should eq("b")
        end
      end

      it "should not find absent component" do
        entity = Entity.new
        expect_raises(Exception, "") do
          entity[TestComponent]
        end
      end
    end

    describe "#[]?(component)" do
      it "should find present component" do
        entity = Entity.new
        component = TestComponent.new
        entity << component
        entity[TestComponent]?.should eq(component)
      end

      it "should not find absent component" do
        entity = Entity.new
        entity[TestComponent]?.should eq(nil)
      end
    end

    describe "#delete(component)" do
      it "should delete component by reference" do
        entity = Entity.new
        component = TestComponent.new
        entity << component
        entity.delete(component)
        entity[TestComponent]?.should eq(nil)
      end

      it "should delete component by type" do
        entity = Entity.new
        component = TestComponent.new
        entity << component
        entity.delete(TestComponent)
        entity[TestComponent]?.should eq(nil)
      end
    end
  end

  context "actions" do
    describe "#<<(action)" do
      it "should add action to actions list" do
        entity = Entity.new
        entity.actions.size.should eq(0)
        entity << Actions::Lambda.new {}
        entity.actions.size.should eq(1)
      end
    end

    describe "#delete(action)" do
      it "should remove action from actions list" do
        entity = Entity.new
        entity << Actions::Lambda.new {}
        entity.actions.size.should eq(1)
        entity.delete(entity.actions[0])
        entity.actions.size.should eq(0)
      end
    end

    describe "#update(delta_time)" do
      it "should trigger update" do
        world = Entity.new

        called = 0
        world << Actions::Lambda.new do |delta_time|
          called += 1
          delta_time.should eq(1)
        end

        called.should eq(0)
        world.update(1)
        called.should eq(1)
      end

      it "should remove actions which are done after update" do
        world = Entity.new
        action = Actions::Lambda.new {}
        world << action
        action.done = true
        world.actions.size.should eq(1)
        world.update(1)
        world.actions.size.should eq(0)
      end
    end
  end

  context "systems" do
    describe "#<<(system)" do
      it "should add system to systems list" do
        entity = Entity.new
        entity.systems.size.should eq(0)
        entity << Systems::Lambda.new {}
        entity.systems.size.should eq(1)
      end
    end

    describe "#delete(system)" do
      it "should remove system from systems list" do
        entity = Entity.new
        entity << Systems::Lambda.new {}
        entity.systems.size.should eq(1)
        entity.delete(entity.systems[0])
        entity.systems.size.should eq(0)
      end
    end

    describe "#update(delta_time)" do
      it "should trigger update" do
        world = Entity.new

        order = [] of Int32
        called = 0
        l1 = Systems::Lambda.new do |entity, delta_time|
          order << 1
          called += 1
          entity.should eq(world)
          delta_time.should eq(1)
        end
        l1.priority = 100
        world << l1
        l2 = Systems::Lambda.new do |entity, delta_time|
          order << 2
        end
        l2.priority = 10
        world << l2

        called.should eq(0)
        world.update(1)
        called.should eq(1)
        order.should eq([2, 1])
      end
    end
  end

  context "children" do
    describe "#size" do
      it "should be zero with no children" do
        entity = Entity.new
        entity.size.should eq(0)
      end

      it "should match children count" do
        entity = Entity.new
        child = Entity.new
        entity << child
        entity.size.should eq(1)
      end
    end

    describe "#all_with_component" do
      it "should find all children with given component" do
        world = Entity.new
        world << Entity.new
        world << Entity.new
        world.children.last << TestComponent.new
        list = world.all_with_component(TestComponent)
        list.size.should eq(1)
      end
    end
    
    describe "#update(delta_time)" do
      it "should trigger update" do
        world = Entity.new
        child = Entity.new
        world << child

        called = 0
        child << Systems::Lambda.new do |entity, delta_time|
          called += 1
          entity.should eq(child)
          delta_time.should eq(1)
        end

        called.should eq(0)
        world.update(1)
        called.should eq(1)
      end

      it "should remove children which are dead after update" do
        world = Entity.new
        child = Entity.new
        world << child
        child.kill!
        world.children.size.should eq(1)
        world.update(1)
        world.children.size.should eq(0)
      end
    end
  end
end
