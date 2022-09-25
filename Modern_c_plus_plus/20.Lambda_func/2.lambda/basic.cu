#include <iostream>
int a = 5;
// Basic synatx --> [](<arguments>)<mutable><excetion specifications> -> return_type
// Here return type is only needed if there are different return statements inside the function

auto func = [](int a, int b) -> int
{
    std::cout << "\n numbers fetched by lamda is = " << a << "," << b;
    return a + b;
};

auto comp = [](auto a, auto b) -> auto                   
{                                           // This way i can use this for comparison operator in basics example    
    return a > b;
};


auto test = [a](auto m, auto n) -> auto
{
    std::cout<<"\n a = "<<a;
    a++;
}
int main()
{
    []() { // Makes anonymous function object
        std::cout << "\n lambda expression";
    }(); // This calls this function
    std::cout << "\n name = " << typeid(func).name();
    auto sum = func(34, 45);
    return 0;
}