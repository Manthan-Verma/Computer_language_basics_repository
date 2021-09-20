#include <iostream>

class copy_constructors
{
    int *p;

public:
    copy_constructors():p{new int{}}
    {
        std::cout<<"\n default";
    }
    copy_constructors(int val)
    {
        std::cout << "\n This is prameterized constructor ";
        p = new int{val};
    }
    copy_constructors(const copy_constructors &data)
    {
        std::cout << "\n This is copy constructor ";
        p = data.p;                                     // This is shallow copy , because both are now pointing to same address space
    }
    /*copy_constructors(const copy_constructors& data)
    {
        std::cout<<"\n This is Copy construtor with deep copy";
        p = new int{*data.p};                               // This is Deep copy , becuase changing the value of one doesnt change the value of other
    }*/
    void show() const
    {
        std::cout << "\n value in p  =  " << *p;
    }
    ~copy_constructors() = default;
};