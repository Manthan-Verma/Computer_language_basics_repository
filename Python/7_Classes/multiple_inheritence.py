# multiple inheritence 

import numpy as np
from math import *

class P1:
    def __init__(self) -> None:
        print("This is P1 constructor")
        pass
    def func(self):
        print("this is func from P1")
        pass
    pass

class P2:
    def __init__(self) -> None:
        print("This is P2 constructor")
        pass
    def func(self):
        print("this is func from P2")
        pass
    pass

class C1(P1,P2):            # multiple inheritence
    def __init__(self) -> None:
        super().__init__()      # calling super class constructor 
        P2.__init__(self)       # calling via name , self passing is nessecary
        pass                    # precendence of super class is 1st --> P1 , 2nd ---> P2(as inheritnce done)
    def __str__(self) -> str:   # Runs when object is called
        return "Name is this"
    pass

c = C1()
c.func()
C1.mro()        # tells method and class priority order 
print(c)