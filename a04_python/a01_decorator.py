# A decorator in Python is a function that adds extra behavior to another function without changing the function's original code.

# Think of it like wrapping a gift:

# 🎁 The gift = your original function.
# 📦 The wrapping = the decorator.
# The gift is still the same, but now it has something extra around it.

from datetime import datetime

def my_decor(func):
    def wrapper(*args, **kwargs):
        print(f'job start at: {datetime.now()}')
        func(*args, **kwargs)
        print(f'end time {datetime.now()}')
    
    return wrapper

@my_decor
def greet(name: str):
    print(f'Hello {name}')

greet("Rajan")

# This is normal function now i want to create some logging without changing anything in this function


def decor(func):
    def wrapper():
        print("started ....")
        func()
        print("end ....")
    return wrapper


@decor
def greeting():
    print("Hello Good Morning")

# greeting()

def hello():
    print("Hello")

hello = decor(hello)
hello()