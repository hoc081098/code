defmodule Problem23 do
  # A perfect number is a number for which the sum of its proper divisors is exactly equal to the number.
  # For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, 
  # which means that 28 is a perfect number.
  # A number n is called deficient if the sum of its proper divisors is less than n
  # and it is called abundant if this sum exceeds n.
  # As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16,
  # the smallest number that can be written as the sum of two abundant numbers is 24.
  # By mathematical analysis, it can be shown that all integers greater than 28123 can be written 
  # as the sum of two abundant numbers.
  # However, this upper limit cannot be reduced any further by analysis even though 
  # it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than
  # this limit.
  # Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
  # Result: 4179871

  def sum_of_proper_divisors(n) do
    1 +
      (Stream.iterate(2, &(&1 + 1))
       |> Stream.take_while(&(&1 * &1 <= n))
       |> Stream.filter(&(rem(n, &1) == 0))
       |> Stream.map(fn i -> if i * i < n, do: i + div(n, i), else: i end)
       |> Enum.sum())
  end

  def solve do
    n = 28123
    abundants = 1..n |> Enum.filter(&(sum_of_proper_divisors(&1) > &1))
    set = MapSet.new(abundants)

    1..n
    |> Enum.filter(fn i ->
      abundants
      |> Enum.take_while(&(&1 <= i))
      |> Enum.all?(fn j -> set |> MapSet.member?(i - j) |> Kernel.not() end)
    end)
    |> Enum.sum()
  end

  def main do
    IO.puts(solve())
  end
end
