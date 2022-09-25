def show(a,b=10):                                      # FUNCTION DEFINATION
    print(" a = ",a)
    print(" b = ",b)
    pass

def add(a,b):
    c = a+b                                             # Returning Function 
    return c

show(10,90.56)                                      #  FUNCTION CALL
show(90)
def main():
    show(86,57.90)
    c = add(89,1)
    print("The sum of data is ",c)
    pass

if __name__=='__main__':                           # Calls main() or anyother function as programe runs 
    main()                              
    pass
