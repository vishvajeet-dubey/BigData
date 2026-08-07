"""
Given a number n, write a formula that returns n!.  
In case you forgot the factorial formula, n! = n * (n - 1) * (n - 2) * ... * 2 * 1.
For example, 5! = 5 * 4 * 3 * 2 * 1 = 120 so we'd return 120.
Assume n is a non-negative integer.
"""


# solve using while loop
# def factorial(n: int) -> int:
#     num = 1
#     while n>1:
#         num = num * n
#         n = n - 1
#     return num
# print(factorial(8))




# solve using for loop
# def factorial(n: int) -> int:
#     num = 1
#     for i in range(2, n+1):
#         num = num * i
#     return num
# print(factorial(3))




# solve using recursive
def factorial(n: int) -> int:
    if n == 0: # break statement
        return 1
    else:
        return n * factorial(n-1)
print(factorial(5))