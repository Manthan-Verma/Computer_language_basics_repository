#include<iostream>

class car
{
    int a{ 10 };        // Default modifier in classes is private
    char name[9] { "Hello \0" };
    static int d;           // INITIALIZATION OUTSIDE THE CLASS
    //auto e{ 5 };              ---> Error because auto is not allowed here 
public:
    
    car():car(90)                          // Default constructor           ,    Also Delegating constructor example
    {
        std::cout << "\n Default constructor ";
    }
    car(int a, char name[9])           // PARAMETRIZED CONSSTRUCTOR
    {
        this->a = a;
	    strcpy_s(this->name, name);
        std::cout<<"\n 2 parameter constructor";
    }
    car(int d):car(90,(char *)"s")
    {
        a = d;
	    std::cout << "\n single variable(int) constructor";
    }
    car(char name[9])
    {
        strcpy_s(this->name, name);
	    std::cout << "\n Single variable(string) constructor";
    }
    void show() const                                           // This is a constant member function that is used to see only details of the class
    {
        std::cout << "\n integer = " << this->a;
	    std::cout << "\n name = " << this->name;
    }
    static void show_static()              // Static function can call another static function and static data only 
    {
        std::cout << "\n static data = " << d;  
    }
    ~car()
    {
        std::cout << "\n destructor is invoked";
    }

};

struct car2
{
    car2()             // Default modifier in structure is public 
    {
        std::cout << "\n Structure default constructor ";
    }
};

int car::d = 10;					// STATIC DATA IS INITIALIZED HERE AND CAN BE ACCSSED EVEN IF ITS PRIVATE
