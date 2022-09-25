class test:
    x = 10
    def __init__(self,y,z) -> None:                 # Consstructor
        self.y =y
        self.z = z                              # self is ---> this as in java 
        pass

    def call(self):                                             # Method --> That contains self 
        print(self.x)
        print(self.y)               # Need to use self to call attributes 
        print(self.z)
    
    pass

a = test(11,20)
print(f" x = {a.x}        y = {a.y}        z = {a.z}")

# We can directly acess x without object but for y and z we nees object as done above 

print(f" x call without object -> {test.x}")

a.call()

 