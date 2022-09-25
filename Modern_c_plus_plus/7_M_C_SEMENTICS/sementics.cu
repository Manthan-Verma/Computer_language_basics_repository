#include"sementics.cuh"

Integer add(volatile int a, volatile int b)
{
    Integer tmp(a + b);
    return tmp;
}

Integer add(Integer& a, Integer& b)
{
    Integer tmp;
    tmp.setvalue(a.getvalue() + b.getvalue());
    return tmp;
}
int main()
{
    Integer x(10), y(90);
    Integer z{ y };
    Integer m{ add(10, 90) };       // Here m calls move sementics constructor 
    x.setvalue(add(x, y).getvalue()); 
    std::cout << "\n Hello";
    test w(90);
    test w1{std::move(w)};              // Synthesizes move constructors for test automatically from integer class
    return 0;
}

