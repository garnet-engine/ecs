require "bisect/helper"

class PriorityQueue(T) < Array(T)
  include Bisect::Helper

  def push(item : T)
    insort_left(item)
  end

  def push(*items : T)
    items.each { |item| push(item) }
  end

  def <<(item : T)
    push(item)
  end
end