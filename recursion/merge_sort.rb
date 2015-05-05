def merge_sort(list)
  # if list size is 1 or 0 it is already sorted.
  return list if list.size <= 1
  # split the list in half and use recursoin on the half list.
  # this will lead to lists of individual elements due to the above return.
  half_list = merge_sort(list.slice!(0..(list.size / 2 - 1)))
  # Do the same with the other half of the list.
  other_half_list = merge_sort(list)
  # While there are elements in either list
  # compare the first elements in each list
  # move the smalller to the sorted list
  # repeat until no more lists to merge
  sorted = []
  until half_list.empty? || other_half_list.empty?
    if half_list[0] < other_half_list[0]
      sorted.push(half_list.shift)
    else
      sorted.push(other_half_list.shift)
    end
  end
  # push any element that remains in the list to empty it.
  until half_list.empty?
    sorted.push(half_list.shift)
  end

  until other_half_list.empty?
    sorted.push(other_half_list.shift)
  end
  sorted
end

p merge_sort([4,76,9,0,23,1,5,99,32,53])
