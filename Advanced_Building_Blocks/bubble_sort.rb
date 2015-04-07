# The Odin Project
# Projects: Advanced Building Blocks
# Project 1: Bubble Sort
#
# Tasks: 1. Use the bubble sort method to sort an array.
#        2. Create a bubble sort methos that uses a block.
# Full details at: http://www.theodinproject.com/ruby-programming/advanced-building-blocks?ref=lnav

def bubble_sort(bubbles)
  n = bubbles.size - 2
  keep_bubbling = true

  while keep_bubbling do
    keep_bubbling = false
    0.upto(n) do |i|
      if bubbles[i+1] < bubbles[i]
        bubbles[i], bubbles[i+1] = bubbles[i+1], bubbles[i]
        keep_bubbling = true
      end
    end
    n -= 1
  end
  p bubbles
end

bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(sort_this)
  n = sort_this.size - 2
  keep_sorting = true

  while keep_sorting do
    keep_sorting = false
    0.upto(n) do |i|
      if yield(sort_this[i], sort_this[i+1]) < 0
        sort_this[i], sort_this[i+1] = sort_this[i+1], sort_this[i]
        keep_sorting = true
      end
    end
    n -= 1
  end
  p sort_this
end

bubble_sort_by(%w[hi hello hey]) do |left, right|
  right.length - left.length
end
