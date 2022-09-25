#include <iostream>
#include <stdio.h>

// This auto initialization doesn't work in classes
auto fsum(int i, int j)
{
    return i + j;
}
/*
                                // AUTO INITIALIZATION KEYWORD
int main()
{
    auto x{ 5 };                // Using auto for initialization(i.e automatically detects the data type)
    auto y{ 90.78f };           // Detects float data type
    auto sum{ x + y };
    std::cout << "\n sum = " << sum;
    auto func_sum{ fsum(10,20) };
    std::cout << "\n function sum = " << func_sum;
    return 0;
}*/

// Range based for loops

int main()
{
    int a[]{1, 2, 3, 4, 5};
    char p[]{"Hello this is world "};
    for (auto &&i : a)
    {
        std::cout << "\n " << i << "     " << p[i];
    }
    return 0;
}