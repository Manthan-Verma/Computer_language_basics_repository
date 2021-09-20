#include <iostream>
#include<stdlib.h>
#include<string.h>

int main()
{
    int a = 5;              // COPY INITIALIZATION ----> sometimes doesnt work and also uses extra mem sometimes
    int b(5);
    int c{ 5 };           // Modern initialization uniform --> enforces initialization
    int d{};            // Assigning 0 to d with unifrom initialization
    int f[10]{ 1,2,3,4,5,6,7,8,9,10 };
    std::string r{ "Hello world" };
    char t[10]{ "Hello wor" };
    int* u = new int{ 99 };
    char* y = new char[10]{ "hi there " };
    std::cout << "\n Hello " << a << "\n" << b << "\n" << c << "\n" << d << "\n" << r << "\n" << t << "\n";
    std::cout << "\n pointers are " << *u << "\n ";
    for (int i = 0; i < 10; i++)
    {
        std::cout << "\n " << y[i] << "     ----->      " << f[i];
    }
    std::cout << "\n ";
    return 0;
}