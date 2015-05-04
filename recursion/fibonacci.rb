def fibs(n)
  seq = [0, 1]
  return "0" if n == 1            # replace with 1 with 0 to count from 0

  while seq.length < n           # replace < with <= to count from 0
    seq << seq[-1] + seq[-2]
  end
  seq.join(", ")
end

puts fibs(11)


def fibs_rec(n, seq = [0, 1])
  return [0] if n == 1            # replace with 1 with 0 to count from 0
  return seq.join(", ") if n == 2 # replace with 2 with 1 to count from 0
  seq << seq[-1] + seq[-2]
  fibs_rec(n - 1, seq)
  seq.join(", ")
end

puts fibs_rec(11)
