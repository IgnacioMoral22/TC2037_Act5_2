defmodule Hw.Primes do

  # No division by 0, so it's always false
  def check_prime(0, _number, _root), do: false

  # Primes can only be divided by themselves and 1, so it's always false
  def check_prime(1, _number, _root), do: false

  # If the number checked is exactly 2, it's false.
  def check_prime(_dividend, number, _root) when number == 2, do: false

  # Leaving the loop, when the list finishes and no division yet, it's prime number
  def check_prime(dividend, _number, root) when dividend>root, do: false

  # Recursive function. If it's exactly divisible by the dividend, it's not a prime number
  # Else, recurse until you find an exact division, or you leave the loop.
  def check_prime(dividend, number, root) when dividend<=root do
    if rem(number, dividend) == 0 do
      true
    else
      check_prime(dividend+1, number, root)
    end
  end

  # If the maximum number is 0, the answer is 0.
  def sum_primes(0), do: 0

  # Call to private function, given a start and a finish, and sending a default result of 0. Used with parallelism.
  def sum_primes({start, finish}), do: do_sum_primes(start, finish, 0)

  # Call to private function, given a finish, and sending a start and default result of 0. Used when calling secuential order
  def sum_primes(limit), do: do_sum_primes(0, limit, 0)

  # If the value checked surprasses the limit, send the result
  defp do_sum_primes(start, finish, result) when start>finish, do: result

  # Recursive function, if the number checked isn't prime, continue.
  # If it is, add the number to the result and continue.
  defp do_sum_primes(start, finish, result) when start<=finish do
    root = trunc(:math.sqrt(start))
    if(check_prime(2, start, root)) do
      do_sum_primes(start+1, finish, result)
    else
      do_sum_primes(start+1, finish, result+start)
    end
  end

  # Dividing the ranges between different threads, with a default value of the maximum number of cores the computer has.
  def sum_primes_parallel(limit, threads \\ System.schedulers) do
    range = div(limit, threads)
    1..threads
    |> Enum.map(fn x -> {range*(x-1)+1, range*x} end)
    |> Enum.map(&Task.async(fn -> sum_primes(&1) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()

  end

end
