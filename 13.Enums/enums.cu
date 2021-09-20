#include"enums.cuh"

enum color {
    RED, GREEN , BLUE
};                                  // Basic enum --> with RED = 1 , GREEN = 2 , BLUE = 3 --> By default 


/*enum cl {                                 // This implementation will cause errors in program furthur as both cl and color has same data members               
    RED, GREEN , BLUE
};*/


enum class cl{                  // This will not create error because its scoped enums as these are called by cl::RED ..... so on 
    RED,GREEN,BLUE
};

enum class d:char{              // Here this enum will have default tpe s char , so here RED = c , GREEN = d , BLUE = e .     
                                //  BUT the storage will be RED = 99 , That is ASCII VALUES 
    RED = 'c',
    GREEN,
    BLUE
};
void display(color co)                      // Here it will not accept any value outside enum color
{
    if(co==0)
    {
        std::cout<<"\n color is RED";
    }
    else if (co == GREEN)
    {
        std::cout<<"\n Color is green ";
    }
    
}
int main()
{
    color c{RED};               // Making a enum object
    display(GREEN);         // passing data for enum object
    display(static_cast<color>(1));             // For integers we have to cast it 

    cl cr{cl::GREEN};               // Making object of scoped enums 

    return 0;
}