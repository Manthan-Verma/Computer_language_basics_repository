#include <iostream>
#include <stdlib.h>
#include<cuda.h>
#include<cufft.h>

                                        // User defined literals should start with _ always , literals without _ are in c++ stl library preddefined.
                                        // Only 4 types allowed ---> long double , unsinged long long , const char* , char ;
                                     
class Distance
{
private:
    long double D_kilometers;

public:
    Distance(long double m) : D_kilometers{m}
    {
    }
    long double get_km() const
    {
        return D_kilometers;
    }
    void set_km(long double val)
    {
        D_kilometers = val;
    }
    ~Distance() = default;
};

Distance operator"" _mi(long double val)                // Syntax for making literals 
{
    return {val * 1.6};
}

long double operator"" _meters(long double val)
{
    return {val / 1000};
}
int main()
{
    Distance dist{32};       // Normal invokation
    Distance dist1{45.0_mi}; // Using literals invokation
    std::cout << "\n " << dist.get_km();
    std::cout << "\n " << dist1.get_km();
    long double a{1500.0_meters};
    std::cout << "\n total = " << a << " km";
    return 0;
}