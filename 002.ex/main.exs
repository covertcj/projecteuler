defmodule Main do
  def sumEvens(n1, n2) when n1 + n2 < 4000000 do
    n3 = n1 + n2
    if rem(n3, 2) == 0 do
      n3 + sumEvens(n2, n3)
    else
      sumEvens(n2, n3)
    end
  end

  def sumEvens(_, _) do
    0
  end
end

IO.puts "#{Main.sumEvens(1, 1)}"
