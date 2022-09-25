#include<iostream>

int add(int x, int y)           // Function returning by VALUE 
{
    return x + y;
}

int& transform(int x)           // FUNCTION RETURNING BY REFRENCE 
{
    x *= x;
    return x;
}

void print(int& x)
{
    std::cout << "\n function int& ";
}
void print(const int& x)
{
    std::cout << "\n function const int& ";
}
void print(int&& x)
{
    std::cout << "\n function int&& ";
}
