#include<iostream>

template<typename T>
void call(const T &&a,const T &&b)
{
    // here lets say i call a object making of a class
    // say --> class_name obj(a,b). --> therefore here 
    // actually a and b is not passed as temprary , but as L values . therfore to 
    // enable passing as it is we do --> class_name obj(std::forward(a),std::forward(b))
}

int main()
{
    call(56,78);
    return 0;
}