module Enumerable

  # 3.
  def my_each
    0.upto(self.size - 1) do |i|
      yield(self.to_a[i])
    end
    self
  end

  # 4.
  def my_each_with_index
    0.upto(self.size - 1) do |i|
      yield(self[i], i)
    end
    self
  end

  # 5.
  def my_select
    selected = []
    self.my_each do |i|
      selected << i if yield(i)
    end
    selected
  end

  # 6.
  def my_all?
    result = true
    self.my_each do |i|
      if block_given?
        result = false unless yield(i)
      end
    end
    result
  end

  # 7.
  def my_any?
    result = false
    self.my_each do |i|
      if block_given?
        result = true if yield(i)
      elsif i != nil
        result = true
      end
    end
    result
  end

  # 8.
  def my_none?
    result = true
    self.my_each do |i|
      if block_given?
        result = false if yield(i)
      elsif i != nil
        result = false
      end
    end
    result
  end

  # 9.
  def my_count(arg = nil)
    count = 0

    self.my_each do |i|
      if block_given?
        count += 1 if yield(i)
      elsif arg != nil
        count +=1 if i == arg
      else
        count += 1
      end
    end
    count
  end

  # 10.
  def my_map
    mapped = []
    self.my_each do |i|
      mapped << yield(i)
    end
    mapped
  end

  # 11.
  # Initially had the same issue as many others:
  # my_inject was not correct for collections starting > 1.
  # Credit to Jason Mathews for the my_each_with_index and unless solution.
  def my_inject(initial = nil)
    total ||= self.first
    self.my_each_with_index do |value, index|
      unless (index == 0 && total == self.first)
        total = yield(total, value)
      end
    end
    total
  end

  # 13. - 14.
  def my_map_mod(a_proc = nil)
    mapped = []
      self.my_each do |i|
        if a_proc && block_given?
          mapped << a_proc.call(yield(i))
        elsif block_given? == false
          mapped << a_proc.call(i)
        end
      end
    mapped
  end

end

# 12.
def multiply_els(els)
  els.my_inject { |product, el| product * el }
end
