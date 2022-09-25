#include"vector.cuh"
                            /* This vector is a class templete 
                             1.For dynamic memory allocation for pointers at runtime we use vectors 
                             2 .  */



void vector_basics()
{
    std::vector<int> val{1,2,3,4,5};            // Initialization
    std::vector<float2> comp;
    
    // Printing or Accesing elements
    for (auto &&i : val)
    {
        std::cout<<"\n value  = "<<i;
    }

    std::cout<<"\n value 1= "<<val[0];
    val[2] = 100;
    for (int i = 0; i < val.size(); i++)            // Another way of accesing 
    {
        std::cout<<"\n val = "<<val[i];
    }
    
    auto it = val.begin();          // return begning address
    std::cout<<"\n value at 3 = "<<*it<<" , at next = "<<*(++it);

    // Deleting and chnging
    std::cout<<"\n "; 
    val.erase(it);
    for (auto &&i : val)
    {
        std::cout<<i<<" ";
    }
    
    // INSERTION
    std::cout<<"\n";
    val.insert(it,2);           // insert(pos, value);
    for (auto &&i : val)
    {
        std::cout<<i<<" ";
    }
    
    val.push_back(90); //--> added at the end of the vector
}

int main()
{
    vector_basics();
    std::cout<<"\n time = "<<__TIME__;                  // This macro gives current time 
    return 0;
}