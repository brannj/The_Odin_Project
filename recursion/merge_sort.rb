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

p merge_sort([1, 2, 4, 3, 10, 9, 8, 7, 6])
