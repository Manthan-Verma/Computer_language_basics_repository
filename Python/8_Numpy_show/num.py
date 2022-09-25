import numpy as np

list1 = [1,2,3,4,5]
list2 = [[1,2,3],[4,5,6],[7,8,9],[10,11,12]]
nparray = np.array(list1)       # Converts list to array

print(nparray.data)             # showa memory location

print(nparray.shape)            # Gives shape of array

nparray2 = np.array(list2)
print(nparray2)                     # creates 2 2d array / matrix 

nparray3 = np.arange(1,10,1)        # Same as range function and creates the array

ar = nparray3.reshape(3,3)           # creates a 3 X 3 matrix / array
print(ar)

a = np.ones((2,2))                     # Unit array with all elements as 1
b = np.zeros((3,3))                    # All elements = 0
print(a,"\n",b)

n = np.ones((3,3),int)              # dtype = int , so makes int array 

c = np.eye(2,dtype=int)             # int ype Identity matrix / array

d = np.linspace(1,10,10,dtype=int)  # creates 10 points between 1 and 10 both inclusive 
print(d)

e = np.random.rand(10)          # creates 10 random numbers 
print(e)

f = np.random.rand(3,3)         # a 3 X 3 random matrix of values between 0 and 1
print(f)

nparray3[:] = 25            # broadcasting That is giving value to all elements 

g = f                   # By refrence by default That is change in 1 is in another as well
t = f.copy()            # copies array with different address


# Matrix Extraction of data
q = nparray2[2,3]           # Simple enough
q = nparray2[1:,2:]         # Extracting a subset

# Extracting with condition -- > 

q = nparray2[nparray2>3]        # Pass condition between paranthesis




arr = np.array([0,1,2,3,4,5])
arr*[0,0,0,0,1,10]                  # Multiply simulateously

arr*arr                             # Same as above 
# + - / all operations are applied same .

arr+100             # 100 is added to all elements


