#include"smart.cuh"

void normal()
{
    Integer *p = new Integer{};
    p->setval(90);
    std::cout<<"\n Value = "<<p->getval();
    // Here destructor for p is not called automatically that is we have to call delete p 
    delete p;  // Because p is  a pointer 
}
void smart_pointer()
{   
    smart m{};
    m.set(90);
    m.get();
    // Here we do not need to do delete m because its an object not a pointer 
    // Therefor it will call destructor here automatically
    // Also we saw that This is how smart pointers help .
    // We have some bult-in smart pointers that we will see furthur
}
int main()
{
    // Normal pointer 
    normal();
    // Smart pointer approximation
    smart_pointer();
    return 0;
}