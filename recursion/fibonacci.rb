# fibonacci number n = fibonacci number n-1 + fibonacci number n-2.
# both solutions start counting from 0.

def fibs(n)
  seq = [0, 1]
  return "0" if n == 0            # replace with 0 with 1 to start count from 1

  while seq.length <= n           # replace <= with < to start count from 1
    seq << seq[-1] + seq[-2]
  end
  seq.join(", ")
end

puts fibs(10)


def fibs_rec(n, seq = [0, 1])
  return [0] if n == 0            # replace with 0 with 1 to start count from 1
  return seq.join(", ") if n == 1 # replace with 1 with 2 to start count from 1
  seq << seq[-1] + seq[-2]
  fibs_rec(n - 1, seq)
  seq.join(", ")
end

puts fibs_rec(10)
