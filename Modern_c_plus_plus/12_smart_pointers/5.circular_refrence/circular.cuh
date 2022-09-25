#include<iostream>
#include<memory>
#include<algorithm>

class project_shared;
class project;
class project_weak;

class Employee
{
private:
    
public:
    project *p;
    Employee()
    {
        std::cout<<"\n Default constructor employee()";
    }
    ~Employee()
    {
        std::cout<<"\n Destructor Employee()";
    }
};

class project
{
private:
    /* data */
public:
    Employee * emp;
    project()
    {
        std::cout<<"\n Default constructor project()";
    }
    ~project()
    {
        std::cout<<"\n Destructor project()";
    }
};

class Employee_shared
{
private:
    
public:
    std::shared_ptr<project_shared> p;
    Employee_shared()
    {
        std::cout<<"\n Default constructor Employee_shared()";
    }
    ~Employee_shared()
    {
        std::cout<<"\n Destructor Employee_shared()";
    }
};

class project_shared
{
private:
    /* data */
public:
    std::shared_ptr<Employee_shared> emp;
    project_shared()
    {
        std::cout<<"\n Default constructor project_shared()";
    }
    ~project_shared()
    {
        std::cout<<"\n Destructor project_shared()";
    }
};

class Employee_weak
{
private:
    
public:
    std::weak_ptr<project_weak> p;
    Employee_weak()
    {
        std::cout<<"\n Default constructor Employee_weak()";
    }
    ~Employee_weak()
    {
        std::cout<<"\n Destructor Employee_weak()";
    }
};

class project_weak
{
private:
    /* data */
public:
    std::weak_ptr<Employee_weak> emp;
    project_weak()
    {
        std::cout<<"\n Default constructor project_weak()";
    }
    ~project_weak()
    {
        std::cout<<"\n Destructor project_weak()";
    }
};