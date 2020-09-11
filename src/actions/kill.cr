class Garnet::Actions::Kill < Garnet::Actions::Instant
  def initialize(@entity : Entity)
    super()
  end

  def update(_delta_time)
    @entity.kill!
  end
end
