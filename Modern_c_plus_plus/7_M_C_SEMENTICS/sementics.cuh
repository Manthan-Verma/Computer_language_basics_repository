#pragma once
#include<iostream>

class Integer
{

public:
	Integer();						// Default Constructor
	Integer(int val);				// Parameterized Constructor
	Integer(const Integer& obj);	// L value copy constructor 
	Integer(Integer&& obj);			// R value copy constructor
	void setvalue(int value);		// Setter
	int getvalue() const;			// Getter
	~Integer();

private:
	int* m_pint;
};

class test
{
	Integer m{};
public:
	test(int val) :m{ val }			//	 Delegating type use this way also 
	{
		std::cout << "\n called to copy ";
	}
};
