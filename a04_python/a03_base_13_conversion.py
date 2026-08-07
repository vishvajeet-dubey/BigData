"""
Given an integer num, return its string representation in base 13.

In case you don’t use base 13 that much (who does, right?), here’s a quick rundown: just like base 10 uses digits from 0 to 9. But also for 10, 11 and 12, we use the letters A, B, and C.

For example:
9 in base 13 is still "9"
10 in base 13 is "A"
11 in base 13 is "B"
12 in base 13 is "C"
13 in base 13 is "10"
14 in base 13 is "11"
49 in base 13 is "3A" (since 3 ∗ 13 + 10 = 49)
69 in base 13 is "54" (since 5 ∗ 13 + 4 = 69)
"""

def convertToBase13(numA:int) -> str :
    conversion = "0123456789ABC"
    # print(conversion[12])
    num = abs(numA)
    base13NumList = []
    if num == 0:
        return 0
    else:
        while num>0:
            quotient = num//13
            remainder = num%13
            base13NumList.append(conversion[remainder])
            num=quotient

    if numA>0:
        return("".join(base13NumList[::-1]))
    else: 
        return("-"+"".join(base13NumList[::-1]))

print(convertToBase13(-1845))

# Solved and getting answer as per expection. check out the below link for more details
# https://datalemur.com/questions/python-base-13-conversion