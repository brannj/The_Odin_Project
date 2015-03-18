# Stock Picker Task - The Odin Project

=begin
Task: Take an array of numbers,
      return the index of the smallest and largest.
      Largest index cannot be less than smallest index.
      Therefore largest cannot be first and smallest cannot be last.

Method: Uses an iteration within an iteration.
        Define a variable to hold subtraction results.
        Subtract 0..-2 from 1..-1 then 1..-2 from 2..-1, etc.
        If result is > than stored value make it stored value and
        store the indexes of each value in an array variable.
=end

def stock_picker(prices)
  days = [0,0]
  profit = 0
  i = 0

  while i < prices.size
    n = i + 1
    while n < prices.size
      dividend = (prices[n].to_i - prices[i].to_i)
      if dividend > profit
        profit = dividend
        days[0] = prices.index(prices[i])
        days[1] = prices.index(prices[n])
      end
      n += 1
    end
    i += 1
  end
  print "Buy at $#{prices[days[0]]} and sell at $#{prices[days[1]]}"
  puts " on days #{days} for a profit of $#{prices[days[1]] - prices[days[0]]}!"
end

stock_picker([17,3,6,9,15,8,6,1,10])
