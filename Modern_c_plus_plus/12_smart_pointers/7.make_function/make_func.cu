#include<iostream>
#include<algorithm>
#include<memory>

class m
{
private:

public:
    m(int a , int b)
    {
        std::cout<<"\n parametrized constructor ";

    }
    ~m() = default;
};


int main()
{
    // IN modern c++ its discared to use new , malloc or other memory allocation operator for smart pointers 
    // Therefor we use like this 
    
    // Earlier 
    std::unique_ptr<int> p{new int{5}};

    {
    // Now we do for unique ptr 
    auto pt = std::make_unique<int>(5);
    auto ptr = std::make_unique<m>(3,4);            // For class m
    auto t = std::make_unique<int[]>(5);
    t[0] = 0;
    }
    {
    //For Shared ptr
    auto pt = std::make_shared<int>(5);
    auto ptr = std::make_shared<m>(3,4);            // For class m
    auto t = std::make_shared<int[]>(5);
    t[0] = 0;
    // If we use mannual new calls in shared then we make 2wice as more new calls as in make shared 
    }

    // Make functions --> cons
        //  Not able to define a coustom deletr

}