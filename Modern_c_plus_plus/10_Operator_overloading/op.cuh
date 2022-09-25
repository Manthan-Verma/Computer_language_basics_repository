#pragma once
#include<iostream>

class Integer
{
public:
	Integer();										// Default constuctor
	Integer(int value);								// Parameterized constructor
	Integer(const Integer& obj);					// copy constructor
	Integer(Integer&& obj);							// Move constructor
	Integer operator +(const Integer& obj)const;	// + operator overloading inside class
	Integer& operator ++();							// Pre icement opearator
	Integer operator ++(int);						// Post incement operator
	int getval() const ;							// Get value function
	void setval(int value);							// Setvalue function
	bool operator ==(const Integer& obj)const;		// comparison operator
	Integer& operator =(Integer& obj);				// assigment copy operator
	Integer& operator = (Integer&& obj);			// assigment move operator 
	~Integer();										// Destructor

private:
	int* m_pint;
};