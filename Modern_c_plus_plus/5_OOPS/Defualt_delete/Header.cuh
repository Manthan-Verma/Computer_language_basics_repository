#include <iostream>

class car
{
    int a;
    char name[10];

public:
    car() = default;                        // Default Here automatically sets up default constructor (i.e puts a = 0 , name = empty)
    ~car() = default;
    car(const car& a) = delete;             // Here Delete Makes sure that this kind of function  implementation cannot be done in this class
    void show() const
    {
        std::cout<<"\n data is a = "<<a<<" \t name = "<<this->name;
    }
};