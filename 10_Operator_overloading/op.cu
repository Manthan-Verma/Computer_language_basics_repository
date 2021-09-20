#include"op.cuh"
/*Integer operator +(const Integer& obj1, const Integer& obj2)
{
    Integer tmp;
    tmp.setval(obj1.getval() + obj2.getval());
    return tmp;
}
*/
std::ostream& operator <<(std::ostream& out, const Integer& a)
{
    out << a.getval();
    return out;
}
std::istream& operator >>(std::istream& in, Integer& obj)
{
    int test;
    std::cout << "\n Enter the value ";
    in >> test;
    obj.setval(test);
    return in;
}
int main()
{
    Integer x(10), y(10);
    //auto a(y);
    //auto b(std::move(y));        // Move sementics
    //y.setval(90);
    //std::cout << "\n value of y = " << y.getval();
    //Integer s = x + y;                // operator + overload
    //std::cout << "\n Value of s = " << s.getval();
    //++x;
    //x++;
   // std::cout << "\n if x==y " << (x == y);
    //Integer d = x;                  // call of copy constructor 
    //d = x;                          // call of assigment operator
    //std::cout << "\n " << d;
    //std::cout << "\n value after x++ = " << x++.getval();
    std::cin >> x;
    std::cout << "\n" << x;
    return 0;
}