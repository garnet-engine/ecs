abstract class Garnet::Actions::Instant < Garnet::Action
  getter? done = false

  def start
  end

  abstract def update(_delta_time)

  def update_wrapped(delta_time)
    return if done?
    update(delta_time)
    @done = true
  end
end
