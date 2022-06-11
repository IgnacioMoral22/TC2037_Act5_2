defmodule Hw.Primes do

  def check_prime(0, _number), do: false
  def check_prime(1, _number), do: false
  def check_prime(_dividend, number) when number == 2, do: false
  def check_prime(dividend, number), do: rem(number, dividend) == 0

  def get_prime_sum(0), do: 0
  def get_prime_sum({start, finish}), do: do_get_prime_sum(start, finish, 0)
  def get_prime_sum(limit), do: do_get_prime_sum(0, limit, 0)
  defp do_get_prime_sum(start, finish, result) when start>finish, do: result
  defp do_get_prime_sum(start, finish, result) when start<=finish do
    root = trunc(:math.sqrt(start))
    prime_check = 2..root
    |> Enum.to_list()
    |> Enum.map(&check_prime(&1, start))
    |> Enum.member?(true)

    if(prime_check) do
      do_get_prime_sum(start+1, finish, result)
    else
      do_get_prime_sum(start+1, finish, result+start)
    end
  end

  def get_prime_parallel(limit, threads \\ System.schedulers) do
    range = div(limit, threads)
    1..threads
    |> Enum.map(fn x -> {range*(x-1)+1, range*x} end)
    |> Enum.map(&Task.async(fn -> get_prime_sum(&1) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()

  end

end
