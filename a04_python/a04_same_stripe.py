"""
You are given an m x n matrix. Your task is to determine if the matrix has diagonal stripes where all elements in each diagonal from top-left to bottom-right are of the same stripe—that is, they are identical.

In this context, each diagonal stripe runs from the top-left corner to the bottom-right corner of the matrix. Check if every diagonal stripe consists entirely of the same number.

Return True if all diagonal stripes are of the same stripe, otherwise return False.

Example #1

Input: matrix = [[42, 7, 13, 99], [6, 42, 7, 13], [1, 6, 42, 7]]

[42, 7,  13, 99]
[6,  42, 7,  13]
[1,  6,  42, 7]]

Output: True

Explanation:
In this grid, the diagonals are:

[1]
[6, 6]
[42, 42, 42]
[7, 7, 7]
[13, 13]
[99]
All elements in each diagonal ar identical. Thus, the answer is True.

Example #2
Input: matrix = [[8, 23], [69, 1]]

[8, 23]
[69, 1]

Output: False

Explanation:
The diagonal [8, 1] does not consist of elements of the same stripe.
"""

def is_same_stripes(matrix):
    same_diagonal_element = {}
    for i in range(1, len(matrix)):
        for j in range(1, len(matrix[i])):
            if matrix[i][j] != matrix[i-1][j-1]:
                return False
    return True

print(is_same_stripes([[42, 7, 13, 99], [6, 42, 7, 13], [1, 6, 42, 7]]))