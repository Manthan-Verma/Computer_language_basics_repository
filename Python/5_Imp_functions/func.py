from math import *


# Range function and use 
def range_function():
    a = list(range(0,11,2))       # Creates data from 0 to 10 with a gap of 2 
    print(f"a ={a} ")
    pass


# Enumerate and useage in functions 
def enumerate_function():
    names = ["Gaurav","yash","swati","nisha","Verma","neha"]
    for i in list(enumerate(names)):        # Binds names with sequence of numbers orderly
        print(f"{i}")
        pass


# Zip Function and Usage 
def zip_function():
    a = [1,2,3,4,5,6]
    names = ["Gaurav","yash","swati","nisha","Verma","sofia"]
    for i,j in list(zip(a,names)):              # Links 2 list of any type simultaniously
        print(f"{i} ---> {j}")
        pass
    pass


# Usage of args in functions 
def args_use(*args):            # *args is used for giving any no of arguments in function call
    print(f"{args}")
    pass


# **Kwargs Usage in functiond
def kwargs_useage(**kwargs):            # Basically this takes input in form of dictionary as you can see in function call
    print(f"{kwargs}")
    pass


# Map function and usage in functions
def map_useage():                         # Map function basically is used to apply specific functions to all elements of a list or other datatype
    names = ["Gaurav","yash","swati","nisha","Verma","sofia"]
    length_names = list(map(len,names))
    print(f" Length of names stored in {names} ---> {length_names}")
    pass


# Filter function and usage
def f(num):
    return (num%2==0) 

def filter_useage():                # Basically filters list of any datatype based on True or False
    a = [0,1,2,3,4,5,6,7,8,9,10]
    result = list(filter(f,a))
    print(f" The filtered result is {result}")
    pass


# Lambda functions and useage 
def lambda_useage():
    square = lambda x : x*x     # Basically this is small way of writing function (you can use any no of variable)
    a = [0,1,2,3]               # A type of Inline functions 
    result_square = list(map(square,a))
    print(f" squared data is ---> {result_square}")
    pass


if __name__ == '__main__':
    #range_function()
    #enumerate_function()
    #zip_function()
    args_use(10,20,30,"Hello")
    kwargs_useage(ID = "Hello", password = "This is python")
    #map_useage()
    #filter_useage()
    #lambda_useage()
    pass
