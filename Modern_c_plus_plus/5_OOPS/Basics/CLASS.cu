#include"Header.cuh"

// Normal basics of class

int main()
{
    char name[9]{ "Harry" };
    car c1{};
    car2 c2{};
    c1.show();
    c1.show_static();
    car::show_static();         // This is how static function is invoked(i.e can be used both ways)

    return 0;
}

