#include"shared.cuh"

Project::Project()
{
	std::cout<<"\n Default constructor project";
}

Project::~Project()
{
	std::cout<<"\n This is destructor of projet ";
}

void Project::setname(const std::string &name)
{
	m_name = name;
}

void Project::show_project_details() const
{
	std::cout<<" [Project name]" << m_name<<"\n";
}

void Employee::set_project(Project *pr)
{
	m_project = pr;
}
const Project * Employee::Getproject() const{
	return m_project;
}
Employee::Employee()
{
	std::cout<<"\n default constructor employee";
}

Employee::~Employee()
{
	std::cout<<"\n destructor employee";
}

void Employee_smart::set_project(std::unique_ptr<Project> &pr)
{
	m_project = std::move(pr);
}
const std::unique_ptr<Project>& Employee_smart::Getproject() const{
	return m_project;
}
Employee_smart::Employee_smart()
{
	std::cout<<"\n default constructor Employee_smart";
}

Employee_smart::~Employee_smart()
{
	std::cout<<"\n destructor Employee_smart";
}

void Employee_shared::set_project(std::shared_ptr<Project> &pr)
{
	m_project = pr;
}
const std::shared_ptr<Project>& Employee_shared::Getproject() const{
	return m_project;
}
Employee_shared::Employee_shared()
{
	std::cout<<"\n default constructor Employee_shared";
}

Employee_shared::~Employee_shared()
{
	std::cout<<"\n destructor Employee_shared";
}
