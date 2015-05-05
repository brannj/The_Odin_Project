# Solution using one method.
# Recursion to split, loop to merge.
def merge_sort(list)

  return list if list.size <= 1

  half_list = merge_sort(list.slice!(0..(list.size / 2 - 1)))
  other_half_list = merge_sort(list)

  sorted = []

  until half_list.empty? || other_half_list.empty?
    if half_list[0] < other_half_list[0]
      sorted.push(half_list.shift)
    else
      sorted.push(other_half_list.shift)
    end
  end

  sorted.concat(half_list)
  sorted.concat(other_half_list)

  sorted
end

# Solution using two recursive methods.
# One to split and one to merge.
def merge_sort_rec(list)
  return list if list.size <= 1
  half = list.size / 2

  merge_rec(merge_sort_rec(list[0..(half - 1)]), merge_sort_rec(list[half..-1]))
end

def merge_rec(half_list, other_half_list)

  return other_half_list if half_list.empty?
  return half_list if other_half_list.empty?

  if half_list[0] < other_half_list[0]
    [half_list.shift].concat(merge_rec(half_list, other_half_list))
  else
    [other_half_list.shift].concat(merge_rec(half_list, other_half_list))
  end
end

p merge_sort([1, 2, 4, 3, 5, 10, 9, 8, 7, 6])
p merge_sort_rec([1, 2, 4, 3, 5, 10, 9, 8, 7, 6])
