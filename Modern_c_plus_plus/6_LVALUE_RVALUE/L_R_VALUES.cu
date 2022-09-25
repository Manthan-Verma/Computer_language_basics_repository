#include"Header.cuh"

int main()
{
    int x{ 9 }, y{ 90 }, z{ 100 };      // HERE x , y and z are L_vlues , also 9 , 90 and 100 are R_VALUES
    // We cannot assign anything to R values becuase they are tempraroies as in above eg 9 , 90, 100 are R values 

    int sum = (x + y) * z;      //  Here (x+y)*z returns a R value  
    // R values cannot persist beyond the expression as in above eg x+y*z is not availaible beyond above line 
    // L values persists beyond expressions like "sum" in above case

    ++sum = 90;                     // Here ++sum returns a L value so it can be on the left side and can be assigned a value 

    std::cout << "\n sum = " << sum;
    
    int func = add(5, 7);               // Functions returning by value always retruns a R VALUE , therefore here add(5,7) cannot be on the Right side 

    //   IN C++11 we can create a refrence to R VALUES USING && OPERATOR 
    int&& r = add(10, 11);          // Cretaes a R value refrence to r (that is  add return a r value )
    int&& e{ 10 };

    //int&& y = transform(89);           --------> ERROR( R VALUES Refrence cannot bind to a L VALUE)
    // int &&t = x;                        --------> ERROR( R VALUES Refrence cannot bind to a L VALUE)

    int& o{ x };                            // Lvalue refrence can always bind to only L value 
    //int& d{ 90 };                            --------> ERROR( L VALUES Refrence cannot bind to a R VALUE)
    const int& w{ 90 };                         // This is allowed only if l value refrence is a constant

    print(x);               // This invokes Lvalue refrence function as x is a l value 
    print(50);                  // Here 50 is a R value but since there is no implementation of R value refrence function or we have commented it out 
                            // therefor this will invoke (const int&) function as we have seen above that const L value can bind to r value 
    // now if i uncomment the r value refrence function and invoke above call again then it will call thr r value refrence function 
}

