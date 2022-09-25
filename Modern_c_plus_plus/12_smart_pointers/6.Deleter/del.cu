#include <iostream>
#include <memory>
#include <algorithm>

struct func // Custom Deleter
{
    void operator()(int *p)
    {
        std::cout<<"\n value freeing = "<<*p;
        free(p);
        std::cout << "\n Pointer freed";
    }
};

void mallocfree(int *p)         // Coustom deletr 2 
{
    free(p);
    std::cout << "\n Coustom deleter 2 ";
}
void normal()
{
    std::unique_ptr<int> p{(int *)malloc(4)};
    *p = 100;
    std::cout << *p << "\n";
    // This can cause problem because every smart pointer will call delete p here
    // But for malloc we need to do free(p)
    // Every smart pointer uses deleter function to call delete
    // so we can have our own implementation of deleter function , so that we can call whatever delete function we want acc to initialization
}

void deleter_example()
{
    std::unique_ptr<int, func> p{(int *)malloc(4), func{}};
    *p = 100;
    std::cout << "\n p = " << *p << "\n";

    std::unique_ptr<int, void (*)(int *)> t{(int *)malloc(4), mallocfree};
    *t = 90;
    std::cout << "\n t = " << *t;
}

void deletr_shared()
{
    std::shared_ptr<int> p{(int *)malloc(4), func{}};           // In shared pointer 1 variable in templete is less to mention
    *p = 100;
    std::cout << "\n p = " << *p << "\n";

    std::shared_ptr<int> t{(int *)malloc(4), mallocfree};
    *t = 90;
    std::cout << "\n t = " << *t;
}

void dynamic()
{
    std::unique_ptr<int> p{new int[5]{1,2,3,4,5}};
    //p[0] = 10;     // cant do it because its not hoe we access dynamic smart pointers
    p.get()[0] = 10; //  ----> now its ok 
    // OR WE CAN DO 
    std::unique_ptr<int[]> k{new int[5]{1,2,3,4,5}};
    k[0]=10;                // --> now its ok 
}
int main()
{
    // Normal issues
    normal();
    // Using delter_function
    deleter_example();
    // Using shared pointer
    deletr_shared();

    //Dynamic arrays
    dynamic();

    return 0;
}