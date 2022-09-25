def main():
    a=int(input("ENTER THE VALUE"))
    if(a==2):
        print("Successfull")
        pass
    elif(a==0):
        print("Not Sucessful")
        pass
    else:
        print(" NOT KNOWN")
        pass
    
    for x in range(1,10,1):
        print(x)
        pass

    data = ['Hello',56,78.0,'this','is']
    for x in data:
        print(x)
        pass
    
    while(x in data):
        print(x)
        pass
    return 5

if __name__ == '__main__' :
    main()
    pass
