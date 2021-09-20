#include"copy.cuh"

int main()
{
    copy_constructors c2{90};
    copy_constructors c3{c2};
    c3.show();
    return 0;
}