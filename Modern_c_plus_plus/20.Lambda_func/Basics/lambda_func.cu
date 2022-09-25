#include <iostream>
// #include <memory>

using comparator = bool (*)(int, int);

template <typename T, int size>
void sort(T (&arr)[size], comparator comp)
{
    for (int i = 0; i < size - 1; i++)
    {
        for (int j = 0; j < size - 1; j++)
        {
            if (comp(arr[j], arr[j + 1]))  // what is we want to sort strings (we write whole algorithm for just this one statement??)
            {                              // We must find a better way . Function pointer can be a way . But this is not a good way
                T tmp = std::move(arr[j]); // As it cannot be inlined so it will cost time. therefre we will use function objects instead of pointers
                arr[j] = std::move(arr[j + 1]);
                arr[j + 1] = std::move(tmp);
            }
        }
    }
}

template <typename T, int size, typename comparator>
void sort1(T (&arr)[size], comparator comp)
{
    for (int i = 0; i < size - 1; i++)
    {
        for (int j = 0; j < size - 1; j++)
        {
            if (comp(arr[j], arr[j + 1]))  // what is we want to sort strings (we write whole algorithm for just this one statement??)
            {                              // We must find a better way . Function pointer can be a way . But this is not a good way
                T tmp = std::move(arr[j]); // As it cannot be inlined so it will cost time. therefre we will use function objects instead of pointers
                arr[j] = std::move(arr[j + 1]);
                arr[j + 1] = std::move(tmp);
            }
        }
    }
}

bool Comp(int x, int y)
{
    return x > y;
}

bool Comp1(int x, int y)
{
    return x < y;
}

struct comp2
{
    bool operator()(int x, int y)
    {
        return x > y;
    }

};

int main()
{
    int arr[]{3, 4, 78, 90, 100, 4, 1, 2};
    // int *arr = (int*)malloc(10*sizeof(int));
    // arr[0] = 0;
    // arr[1] = 12;
    // arr[2] = 11;
    // arr[3] = 7;
    // arr[4] = 90;
    // arr[5] = 87;
    // arr[6] = 8;
    // arr[7] = 6;
    // arr[8] = 1;
    // arr[9] = 9;

    sort(arr, Comp1);

    for (auto &&i : arr)
    {
        std::cout << "\n arr = " << i;
    }
    // Here is i do 
    comp2 co;
    sort1(arr,co);              // This way call to struct comp will be inlined and performs better 
    return 0;
}