#include <iostream>
#include <stdio.h>
#include <memory>
#include <algorithm>
#include <string>
#include <sstream>
#include <initializer_list>
#include <cassert>
                                        /* Pourpose of initializer list is to define object just like an array , espacially if its a container class
                                           1 . Represents an array of objects.
                                           2. Constructs automatically from a braced list of elements --> { }
                                           3. Acess to elements through iterators (like range based for loop)*/     
class Bag
{
private:
    int arr[10];
    int size{};

public:
    Bag(std::initializer_list<int> elements)
    {
        assert(elements.size() < 10);
        for (auto &&i : elements)
        {
            add(i);
        }
    }
    void add(int val)
    {
        assert(size < 10);
        arr[size++] = val;
    }
    void remove()
    {
        --size;
    }
    int operator[](int index)
    {
        return arr[index];
    }
    int getsize() const
    {
        return size;
    }
    ~Bag() = default;
};
int main()
{
    std::string name{"Manthan Verma"};
    int arr[5]{1, 2, 3, 4, 5};
    std::initializer_list<int> array{2, 2, 3, 4, 5};
    for (auto &&i : array)
    {
        std::cout << "\n val = " << i;
    }
    std::cout<<"\n array = "<<array.begin()[3];
    Bag n{1,2,3,4,5};
    std::cout<<"\n size initialized = "<<n.getsize();
}
