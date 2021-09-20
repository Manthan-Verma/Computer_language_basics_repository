#include"circular.cuh"

void normal()
{
    project *prj = new project{};
    Employee * e = new Employee{};

    e->p = prj;
    prj->emp = e;
    delete prj;
    delete e;
    // This works fine but lets see the implementation of Shared pointer 
}
void shared_ptr()
{
    std::shared_ptr<project_shared> prj{new project_shared{}};
    std::shared_ptr<Employee_shared> emp{new Employee_shared{}};

    prj->emp = emp;
    emp->p = prj;

    // This causes problem because due to circular refrence count of no of refrences goes above 1 
    // and smart pointer shared doesnt destroy in end 
    // Therefore memory leaks are there
}

void weak()
{
    std::shared_ptr<project_weak> prj{new project_weak{}};
    std::shared_ptr<Employee_weak> emp{new Employee_weak{}};

    prj->emp = emp;
    emp->p = prj;
    // Thos solves the circular refrence problem 
}
int main()
{
    // Normal implementation
    normal();
    // Shared implementation
    shared_ptr();
    // weak ptr implementation
    weak();
    return 0;
}