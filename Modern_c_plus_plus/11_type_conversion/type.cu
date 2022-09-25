#include"type.cuh"
                                // CONVERTING 1 TYPE to ANOTHER 

void convert(const test& a)
{
    std::cout<<"\n Hello";
}
void type_conversion_premitive_to_user_defined()
{
    test a{90};             // explicit invoking parameterized constructor
    //test b = 8;             // impicit invoking parameterized constructor --> Gives error because we have declared cnstructor as explicit
    //convert(90);            // converts 90 to object by invoking constructor --> but gives error because declared explicit
}

void type_conversion_user_to_primitive()
{
    test a{90};
    //int x = a;  // error because compiler doesnt know how to convert user defined datatype to primitive
    // After implimenting operator function in class we can do this
    int x = a;
    std::cout<<"\n value of a = "<<x;

}
int main()
{
    int a{2},b{5};
    float c = b/a;      //      GIVES RESULT 2
    //float c{b/a}          ---> Reports error because of narrowing conversion( Therefore this type of initialization is good to use )
    float d {(float)b/a};   //  --> gives 2.5 output but is c-style cast and is not safe to use 
                        // THEREFORE LETS SEE ALL 3 TYPES OF C++ CASTINGS
    casting_types();
    type_conversion_premitive_to_user_defined();
    type_conversion_user_to_primitive();    
    return 0;
}