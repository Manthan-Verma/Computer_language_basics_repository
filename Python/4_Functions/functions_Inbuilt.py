                                    # BUILT IN FUNCTIONS
a = input("enter a number / string ")                   # ALWAYS TAKES AND ASSIGNS AS STRING
print("\n a \\n")                           

print(eval('15'))                               # prints the evaluated output

print(eval('15*90-10'))                          # Evaluate the expression and then prints it 

print(" Hello world \\n ")                      # use \ in front of special charactor to print it 

print(type(" Hello wolrd "))                       # PRINTS THE TYPE OF ARGUMENTS PASSED
print(type(190.9))                                             

m = int(input(" Enter the input : "))               # converts entered as int 


import random
a = random.random()                                             # GENERATED RANDOM  VALUE (BETWEEN 0 AND 1)
print(a)                                

print(random.randint(1,4))                          # GENERATES RANDOM VALUES BETWEEN 1 AND 4 in integer 

print(id(a))                                                    # Python assigns unique id to every variable , sometimes can be called as address

print(min(1,2,3,4,78,0))                                # Min of data provided, For string data type compares ascii values (But cannot be mix string and float etc)
print(max(1,2,3,4,78,0))                                # Max of Data provided

print(pow(3,2))                                         # Power of 3^2

