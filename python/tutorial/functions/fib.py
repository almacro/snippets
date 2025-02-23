def fib(n):    # write Fibonacci series less than n
    """Print s [200~ Fibonacci series less than n."""
    a, b = 0, 1
    while a < n:
        print(a, end=' ')
        a, b = b, a+b
    print()

# python3
# >>> from fib import fib
# >>> fib(2000)
# 0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597
