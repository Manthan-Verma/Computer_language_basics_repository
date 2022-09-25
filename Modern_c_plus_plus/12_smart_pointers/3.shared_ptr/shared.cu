#include"shared.cuh"


void show_info(Employee *emp)
{
    emp->Getproject()->show_project_details();
}

void normal()
{
    Project *prj = new Project{};
    prj->setname("Video decoder");
    Employee *e1 = new Employee{};
    e1->set_project(prj);
    Employee *e2 = new Employee{};
    e2->set_project(prj);
    Employee *e3 = new Employee{};
    e3->set_project(prj);
    
    show_info(e1);
    show_info(e2);
    prj->show_project_details();

    delete prj;
    delete e1;
    delete e2;
    delete e3;
}
void show_info_smart(std::unique_ptr<Employee_smart> &emp)
{
    emp->Getproject()->show_project_details();
}
void smart_p_unique()
{
    std::unique_ptr<Project> prj {new Project{}};
    prj->setname("Video decoder");
    std::unique_ptr<Employee_smart> e1{new Employee_smart{}};
    e1->set_project(prj);
    std::unique_ptr<Employee_smart> e2{new Employee_smart{}};
    e2->set_project(prj);
    std::unique_ptr<Employee_smart> e3{new Employee_smart{}};
    e3->set_project(prj);
    
    show_info_smart(e1);
    show_info_smart(e2);      //  ---> this will show segmentation fault 
    //because Here we cannot do anything because we cannot share unique ptr with more than once in our code 
    // as dome in line no 36 and 38 ... etc; because its moved at first attempt
    prj->show_project_details();
}
void show_info_shared(std::shared_ptr<Employee_shared> &emp)
{
    emp->Getproject()->show_project_details();
}
void shared_p()
{
    std::shared_ptr<Project> prj {new Project{}};
    prj->setname("Video decoder");
    std::shared_ptr<Employee_shared> e1{new Employee_shared{}};
    e1->set_project(prj);
    std::shared_ptr<Employee_shared> e2{new Employee_shared{}};
    e2->set_project(prj);
    std::shared_ptr<Employee_shared> e3{new Employee_shared{}};
    e3->set_project(prj);
    
    show_info_shared(e1);
    show_info_shared(e2);
    prj->show_project_details();

    // shared pointer keeps a count of no of copies of an onject 
    // to see total count
    std::cout<<"\n Total count = "<<prj.use_count();
    // shared pointer desptrys itself when count becomes 0 
    // Here reset function is same as unique pointer 
    e3.reset();       // or e3.reset(new Employee_shared{});
    // e3.reset decement the refrence count 

}
int main()
{
    // this is normal implementation of pointers Therefore we have to all memory updation dletion by ourselves
    normal();
    // now using smart pointers 
    // Here we didnt do memory updation deleltion by ourselves , but
    // Here we cant share the pointer as you will see in this function implementation
    smart_p_unique();
    // now Using shared pointers
    shared_p();
    return 0;
}