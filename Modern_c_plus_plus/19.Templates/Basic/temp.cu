#include <iostream>

// Template code for specific type depending on call is made at compile time . therfore 
// no runtime cost is there
template <typename T>                   // This is how a basic 
auto max(T x, T y)                      // template function is made
{
    return (x > y) ? x : y;
}



// explicit instantiation
template<> auto max(const char *a,const char *b)
{
    std::cout<<"\n type = "<<typeid(a).name();
    return strcmp(a,b) > 0 ? a : b;
}

template<typename T, int m>                 // here m is a non-template parameters so while passing it should be constant
T v(T a)
{
    // even here also we cant do :
    // m++;
    std::cout<<"\n val = "<<m;
    return m;
}

template<typename T, int size>                 // like this it can auto detect size of array
T call_sum(T (&a)[size])
{
    T sum{0};
    for (size_t i = 0; i < size; i++)
    {
        sum += a[i];
    }
    return sum;
}

int main()
{
    // int maximum = max(45,67);
    auto maximum = max<float>(45.7,67);         // Calling according to type 
                                            // calling ----> max<float> is only if to override default type , else
                                            // max() will also work



    // Explicit instantitaton ( if i want to define template function for specific type explicitly)
    
    std::cout<<"\n data = "<<max("A","B");

    std::cout<<"\n maximum is = "<<maximum;

    // non template arguments   
    auto f = v<int,5>(67);          // Here if we put variable in place of 5 it will show error

    float array_1[]{1,78.8,90.5};
    std::cout<<"\n sum = "<<call_sum(array_1);
    return 0;
}