defmodule Main do
  def sum_less_than(max, increment, current \\ 0) when current < max do
    sum_less_than(max, increment, current + increment) + current
  end

  def sum_less_than(_, _, _) do
    0
  end
end

fives  = Main.sum_less_than(1000, 5)
threes = Main.sum_less_than(1000, 3)
fifteens = Main.sum_less_than(1000, 15)

IO.puts("#{fives + threes - fifteens}")
