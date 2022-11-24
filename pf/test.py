
def my_size (lista, leng):
    if(len(lista) == 0):
        return (lista, leng)
    else:
        return my_size(lista[1:],leng+1)



list =[1,2,3,4,4,5]
print(
my_size(list,0)
)