#pragma once
#include<iostream>
#include<memory>
#include<algorithm>

class Project
{
private:
	std::string m_name;
public:
	Project();
	void setname(const std::string &name);
	void show_project_details() const;
	~Project();
};

class Employee
{
private:
	Project *m_project{};
public:
	Employee();
	void set_project(Project *pr);
	const Project * Getproject() const;
	~Employee();
};


class Employee_smart
{
private:
	std::unique_ptr<Project> m_project{};
public:
	Employee_smart();
	void set_project(std::unique_ptr<Project> &pr);
	const std::unique_ptr<Project>& Getproject() const;
	~Employee_smart();
};

class Employee_shared
{
private:
	std::shared_ptr<Project> m_project{};
public:
	Employee_shared();
	void set_project(std::shared_ptr<Project> &pr);
	const std::shared_ptr<Project>& Getproject() const;
	~Employee_shared();
};