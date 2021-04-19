defmodule Problem2 do
  # Each new term in the Fibonacci sequence is generated by adding the previous two terms.
  # By starting with 1 and 2, the first 10 terms will be:
  # 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
  # By considering the terms in the Fibonacci sequence whose values do not exceed four million,
  # find the sum of the even-valued terms.
  # Result: 4613732

  require Integer

  def solve do
    Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end)
    |> Stream.drop(2)
    |> Stream.take_while(fn i -> i <= 4_000_000 end)
    |> Stream.filter(&Integer.is_even/1)
    |> Enum.sum()
  end

  def main do
    IO.puts(solve())
  end
end