
# python number pattern
rows = 10
num = 1

for i in range(1, rows + 1):
    print(" "*(rows - i), end='')
    for j in range(i):
        print(num, end=' ')
        num += 1

    print() 
