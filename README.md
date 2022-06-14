# TC2037_Act5_2

To run this program, use iex Tarea_Paralela.exs

For running a prime sum in secuential order, run Hw.Primes.sum_primes(number), changing number for the maximum number to which you want to sum to.

For running a prime sum in secuential order, run Hw.Primes.sum_primes_parallel(number), changing number for the maximum number to which you want to sum to.
By default, this will attempt to use the maximum number of cores your computer has. If you want to use less cores, you can run Hw.Primes.sum_primes_parallel(number, cores), changing "cores" to the number of threads you wish to start.

## Running to 5,000,000
If we run Hw.Primes.sum_primes(5000000), the result is correct, showing 838596693109. This takes 15.753523 seconds.

If we run Hw.Primes.sum_primes_parallel(5000000, 4), since my machine has 4 cores, the result is also 838596693109, but it takes 5.934796 seconds instead.

## Measuring time complexity
The program runs in O(nm), where n is the maximum number asked, and m is each iteration to check whether a number is prime from 2 to the square root of m.
