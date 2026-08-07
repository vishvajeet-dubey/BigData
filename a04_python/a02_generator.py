def my_func(lst: list):
    for i in lst:
        yield i

result = my_func([1,2,2,34,2,23,44])
print(next(result))
print(next(result))
print(next(result))
print(next(result))
print(next(result))