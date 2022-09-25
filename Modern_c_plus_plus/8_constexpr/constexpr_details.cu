#include"constexpr_details.cuh"
// 1. constexpr should expect and return literals only (void scalr types(int ,char , float) , refrences and class having constexpr constructor etc 
// 2. constexpr should contain only single line comment mostly or consditional statements only 
// 3. All constexpr are impicitly inlined 
int main()
{
    // Behaves As a constxpr function
    constexpr int i = getnumber();                  //      (Solved at Compile time only)
    //constexpr int j = get();          -------> This will not work (See the function)
    int arr[i];                 //          -----> Works now 

    // Behaves as constexpr function
    const int j = getnumber();          // works with const also                (solved at runtime only)
    int arre[j];

    // Behaves As Normal Function
    int x = getnumber();                // Behaves as normal function  and is compiled at the run time only

    //constexpr w = add(x, 5);              // Error becuase of constexpr cannot be variable 

    int sum2 = add(23, 45);             // Normal function
}
