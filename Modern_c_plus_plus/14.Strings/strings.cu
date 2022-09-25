#include "strings.cuh"

// Basic c style strings ---> Very clusterous
/*
const char* combine(const char* first , const char* last)
{
    char* fullname {new char[strlen(first)+strlen(last)]};
    strcpy(fullname,first);
    strcat(fullname,last);
    return fullname;
}

int main()
{
    char first[10];
    char last[10];
    std::cout<<"\n enter the first and last name";
    std::cin.getline(first,10);
    std::cin.getline(last,10);
    const char* full = combine(first,last);
    std::cout<<'\n full name = '<<full;

    return 0;

}*/

// Lets ude c++ string class that is esy to use and implement


void string_streams()
{
    int a{6},b{7};
    int sum{a+b};
    std::cout<<"\n sum of "<<a<<" and "<<b <<" is "<<sum;                   // in textboxes doesnt work with cout
    // Therefor we do 
    //std::string s{"sum of "+ a +" & "+ b +" is "+sum};            //--> will give error because we are adding strings and integers , and conversion will no happen automatically

    // Therefore now use streams
    std::stringstream st;           //--> for boh input and output    where istringstream is for input anly and ostringstream is for output only  
    st <<"sum of "<<a<<" and "<<b<< " is "<<sum;            // Goes to string stream buffer that can be accesed as next line
    
    std::string t{st.str()};        // Now  string.str() --> has 2 overloads , 1-> is where is returns string as in buffer as shown here 
    //st.str("");                                // This is second overload where we assign string stream buffer a string 


    st << sum ;             // Now this statement will add the data in variable sum to stream st 
    std::cout<<"\n "<<st.str();     // to print we have to had string returned from stream  

    // We can clear buffer before adding as 
    st.str("");
    st <<sum;
    std::cout<<"\n "<<st.str();


    // To convert any type to string we need to do is 
    auto s = std::to_string(sum);
    std::cout<<"\n "<<s;



    st.str("");
    //     Now most imp thing is we can use string strems also to parse integers from string
    using namespace std::string_literals; 
    auto str{"89 90 911 09"s};          // This is how also we can define strings
    st << str;
    while (st >> str)
    {
        std::cout<<"\n  string is = "<<str;
    }

                    // Few imp functions 
    auto d{ std::stoi("90")};           // converts string to integer 
}

int main()
{
    // INITIALIZATION
    std::string name{"Manthan"}, last;
    last = "Verma";

    //Accessing elements
    name[4] = 'H';
    char ch = last[2];
    std::cout << "\n " << name << "      " << ch;
    //std::cin>>last;             // Not including spaces
    std::getline(std::cin, last); // reads spaces also
    std::cout << "\n entered last = " << last;

    // Size of elements
    std::cout << "\n name length = " << name.length(); // String class object caches the length therefore string class frquent operations are
                                                       // Faster than raw c style strings

    // Insertion and concatenation
    std::string f{"Hello"}, g{" World"};
    std::string con{f + g}; // All these types of concatenation is valis in string class
    f += g;

    f.insert(6, g); // has lost of overload explore all

    // Comparison

    if (f == g) // We can nomaly use comparison as in other variables
        std::cout << "\n Hello world ";
    
    // Removal and erase 

    f.erase(6);             // erases at position 6
    f.erase(0,5);           // removes 1st 6 charactars  
    f.erase();                // erases full string   
    f.clear();              // same as above 
    
    //SEARCH

    auto pos {g.find("he",0)};      // serches for string he starting from element 0 in g 
    if(pos != std::string::npos)        // if not found npos = -1 and pos = -1 
    {
        std::cout<<"\n found";
    }
    
    // Few more things 
    //if i want a cstyle string to print as in printf functions --> therefor do this 
    printf("%s",g.c_str());     // string_name.c_str() ---> returns c style string 



        // Now we must learn to use string streams 
    string_streams();


    return 0;
}