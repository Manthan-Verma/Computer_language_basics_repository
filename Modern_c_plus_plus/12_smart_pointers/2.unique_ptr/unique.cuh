#include<iostream>
#include<cuda.h>
#include<stdio.h>
#include<memory>
#include<algorithm>

class Integer
{

public:
	Integer();						// Default Constructor
	Integer(int val);				// Parameterized Constructor
	Integer(const Integer& obj);	// L value copy constructor 
	Integer(Integer&& obj);			// R value copy constructor
    Integer operator =(int val); //operator overloading = 
	void setvalue(int value);		// Setter
	int getvalue() const;			// Getter
	~Integer();

private:
	int* m_pint;
};