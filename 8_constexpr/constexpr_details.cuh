#include <iostream>

int get()
{
    return 0;
}

constexpr int getnumber() {
    return 10;
}

constexpr int add(int x, int y)
{
    return x + y;
}

constexpr int max(int x, int y)
{
    if (x > y)
        return x;
    return y;
}