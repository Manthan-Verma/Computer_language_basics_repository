#include<iostream>
#include<cuda.h>
#include<memory.h>

class test
{
private:
    int a{10};
    int *p;
public:
    test():p{new int{}}
    {
        std::cout<<"\n default constructor";
    }
    explicit test(int val)
    {
        std::cout<<"\n parameterized constructor";
        p = new int{val};
    }
    operator int()              // No return type , no arguments
    {
        return *p;
    }
    ~test() = default;
};

void casting_types()
{
    std::cout<<"\n Inside casting types";
    int a{5},b{2};
    float c = static_cast<float>(a)/b;              // Static cast used to cast normally but also checks vidity of cast 
    std::cout<<"\n after casting c = "<<c;

    // Reinterpret casting ( changing types)
    char *p{reinterpret_cast<char*>(&a)};     // Converting int* to char*
    std::cout<<"\n after reinterpret cast p = "<<p[0];

    //const casting
    const int t{10};
    int*d{(int*)&t};            // Cstyle casting
    int *m{const_cast<int*>(&t)};       // Const cast 

}
