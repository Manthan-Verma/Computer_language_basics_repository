#include"unique.cuh"

                                        /* Unique pointers (smart pointers .)
                                            1. To transfer the ownership of object to a function
                                            2. 
                                        */
void display(Integer* p)
{
    if(!p)
    {
        return;
    }
    std::cout<<"\n "<<p->getvalue();
}

Integer* GetPointer(int value)
{
    Integer* p = new Integer{value};
    return p;
}

void store(std::unique_ptr<Integer> p)
{
    std::cout<<"\n Storing data in value: "<<p->getvalue();
}
void store1(std::unique_ptr<Integer> &p)
{
    std::cout<<"\n Storing data in value: "<<p->getvalue();
}
void operate(int value)
{
    std::unique_ptr<Integer> p{GetPointer(value)};
    if(p==nullptr)
    {
        //p = new Integer{value};
        p.reset(new Integer{value});
    }
    p->setvalue(100);
    //display(p);           ----> after using the smart pointers cannot directly pass smart pointers unless it accepts a smart pointer 
    display(p.get());           // p.get() is used to pass the pointer object that doesn't accept smart pointers.
    // delete p;            --------> now cannot do becuase p is not a pointer after using smart pointers its an object
    //p = nullptr;        // ----> valid in smart pointers (This statement is like calling delete on a pointer and assigning it to nullptr)
    // p = new Integer{};   --- > cannot do this to smart pointers 
    p.reset(new Integer{}); // ---> reset deletes the p pointer and then take the ownership of the new pointer .
    *p = __LINE__;
    display(p.get());
    //store(p);   // This  doesnt work because copy constrictor of unique pointer is deleted
    store1(p);                  // -----> this works because we have given pass by refrence .
    store(std::move(p));  //--> we can move it instead of copying
    //delete p;
    // p is destroyed here 
}

int main()
{
    int val;
    std::cout<<"\n enter the value = ";
    std::cin>>val;
    operate(val);
    return 0;

}