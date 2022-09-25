#include "Header.cuh"
//                                  BASICS OF POINTERS
/*
int main()
{
    int x{ 10 };
    int* p1{ &x };      // Making P1 points to adress of x
    std::cout << "\n address of p1 = " << p1 << "  , value at p1 = " << *p1;
    std::cout << "\n address of x = " << &x << "  , value at x = " << x;

    *p1 = 70;
    std::cout << "\n\n AFter change ";
    std::cout << "\n address of p1 = " << p1 << "  , value at p1 = " << *p1;
    std::cout << "\n address of x = " << &x << "  , value at x = " << x;
    std::cout << "\n\n\n";

    int* p2 = new int{ x };         // Creates the new memeory with value of x 
    std::cout << "\n address of p2 = " << p2 << "  , value at p2 = " << *p2;
    std::cout << "\n address of x = " << &x << "  , value at x = " << x;
    
    *p2 = 88;
    std::cout << "\n\n after change ";
    std::cout << "\n address of p2 = " << p2 << "  , value at p2 = " << *p2;
    std::cout << "\n address of x = " << &x << "  , value at x = " << x;

    int* p3 = new int[] {1, 2, 3, 4, 5, 6, 7, 8, 9};            // Cretes a array of pointers on heap 
    std::cout << "\n\n\n Array of pointers :";
    std::cout << "\n p3[2] = " << p3[2];
    std::cout << "\n adress of p3[2] , p3[0] = " << &p3[2] << "  " << &p3[0];

    ++(p3);                         // p3 contains adress of p3[0] element ,  ++(p3) goes to next adress that is --> p3[1]
    std::cout << "\n p3 = " << *p3;
    return 0;
}
*/

//                              void nullptr and refrences 
/*
int main()
{
    int x = 10;
    void* p{ &x };                        // VOID POINTER ----> CAN BE ASSINGED TO ANY TYPE OF VALUE 
    std::cout << "\n value of p = " << *(int*)p;                // Casting it to type of pointer to print
    

    auto* y = new int [] {1, 2, 3, 4, 5, 6, 7, 8, 9};
    // After using data in pointers to remove or free the memory do this 
    delete[] y;          // or we can also do free(y)
    y = nullptr;            

    void* z{ nullptr };         // Instead of NULL marco now use this --> nullptr (type safe )
    
    
    int& ref{ x };                // Assigns the adress of x with ref  ( Always need initializers)
    std::cout << "\n\n   ref adress = " << &ref << " ,     value at ref = " << ref;
    std::cout << "\n   x adress = " << &x << " ,     value at x = " << x;
}*/


//                      CONSTANTS 
/*
int main()
{
    const int x{ 10 };                  // const is used instead of MARCOS 
    //int* p{ &x };         ----> error because const cannot be assinged to non-const pointer 

    const int* p1{ &x };            //----> Now Works fine 

    int* const p = new int{ 89 };   // ---> Here Adress is constant But value can change 
    //p++;                          ---> Error becuase adress is conatnt 
    std::cout << "\n value of p = " << *p << "   , adress of p = " << p;
    *p = 90;                                // Valid because value is not constant 
    std::cout << "\n value of p = " << *p << "   , adress of p = " << p;


    const int* p2 = new int{ 78 };          // ----> Here adress can change but value is contant 
    p2++;                                   // ---> Alllowed because adress is not constant 
    //*p2 = 90;                                         -------> Failed becuase value is contant 

    int const* const p4  = new int{ 0 };                // Both adress and value are constant 

    // To avoid this confusion we can do :
    const int& ref(x);                      // Here ref is conatnt  and niether adresss or value can change 


    return 0;
}*/


//                      Functions Pointers
/*
int s(int a)
{
    return 10 * a;
}
void show()
{
    std::cout << "\n end of function ";

}
int main()
{
    atexit(show);                       // No matter where you call atexit() function it invokes at the end of ucntion only 
    int (*pfn)(int) { s };              // CREATES A variable pointer(*pfn ) and links to call of function adress s

    std::cout << "\n value  = " << pfn(7);   // Therefore we call functions without knowing the function name 

    return 0;
}*/



//                          DEEP AND SHALLOW COPY 
/*
int main()
{
    int* p = new int{ 90 };
    int* p1 = p;                    // THIS iS THE SHALLOW COPY THAT IS IT COPIES THE ADRESS

    cout << "\n p1 = " << *p1 << "    p = " << *p;
    *p1 = 99;
    cout << "\n p1 = " << *p1 << "    p = " << *p;

    auto* p2 = new int{ *p };       // Performs a deep copy 

    cout << "\n p1 = " << *p2 << "    p = " << *p;

    *p2 = 80;
    cout << "\n p1 = " << *p2 << "    p = " << *p;

    int* p3{ p };                         // A type of shallow copy 
    cout << "\n p3 = " << *p3 << "    p = " << *p;

    *p3 = 78;
    cout << "\n p3 = " << *p3 << "    p = " << *p;


}*/