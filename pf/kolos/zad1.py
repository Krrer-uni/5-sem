def mysum(list, curr, size, acc):
    if (list == []) :
        return acc
    return mysum(list[1:],curr+1,size,acc +list[0]*list[0]*list[0]*curr)


ls=[1,2,3,4]
print(mysum(ls,0,len(ls),0))

