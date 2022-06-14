defmodule Hw.Primes do

  def check_prime(0, _number, _root), do: false
  def check_prime(1, _number, _root), do: false
  def check_prime(_dividend, number, _root) when number == 2, do: false
  def check_prime(dividend, _number, root) when dividend>root, do: false
  def check_prime(dividend, number, root) when dividend<=root do
    if rem(number, dividend) == 0 do
      true
    else
      check_prime(dividend+1, number, root)
    end
  end

  def sum_primes(0), do: 0
  def sum_primes({start, finish}), do: do_sum_primes(start, finish, 0)
  def sum_primes(limit), do: do_sum_primes(0, limit, 0)
  defp do_sum_primes(start, finish, result) when start>finish, do: result
  defp do_sum_primes(start, finish, result) when start<=finish do
    root = trunc(:math.sqrt(start))
    if(check_prime(2, start, root)) do
      do_sum_primes(start+1, finish, result)
    else
      do_sum_primes(start+1, finish, result+start)
    end
  end

  def sum_primes_parallel(limit, threads \\ System.schedulers) do
    range = div(limit, threads)
    1..threads
    |> Enum.map(fn x -> {range*(x-1)+1, range*x} end)
    |> Enum.map(&Task.async(fn -> sum_primes(&1) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()

  end

end
