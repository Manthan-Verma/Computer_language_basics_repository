#include"weak.cuh"

void normal()
{
    Printer prn;
    int num{};
    std::cin>>num;
    int*p = new int{num};
    prn.setval(p);

    if(*p>10)
    {
        delete p;
        p = nullptr;
    }
    prn.print(); 
    delete p;
    // Here in this code if *p>10 then prn.print() --> will show junk value 
    // We also cannot coordinate via checker in print function 
    // because m_value may not be nullptr while p is nullptr
    // lets try with shared smart pointer variable
}

void shared_ptr()
{
    Printer_shared prn;
    int num{};
    std::cin>>num;
    std::shared_ptr<int>p{new int{num}};
    prn.setval(p);

    if(*p>10)
    {
        //delete p;
        p = nullptr;
    }
    prn.print(); 
    //delete p;
    // Here in this example we see that till count of shared pointer is not zero it will not destroy itself
    // Therefore here it still prints the output 
    // Lets use Weak pointers  
}
void weak_ptr()
{
    // Weak pointer are always made on shared pointers only that keeps the ref count known
    // also as you can see the class in weak pointer how to check for memory 
    Printer_weak prn;
    int num{};
    std::cin>>num;
    std::shared_ptr<int>p{new int{num}};
    prn.setval(p);

    if(*p>10)
    {
        //delete p;
        p = nullptr;
    }
    prn.print();
}
int main()
{
    // Normal
    normal();
    //shared_pointer
    shared_ptr();
    //weak pointer
    weak_ptr();
    return 0;
}