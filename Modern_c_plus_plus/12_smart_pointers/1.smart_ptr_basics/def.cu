#include "smart.cuh"

Integer::Integer()
{
	std::cout << "\n default constructor  ()";
	m_pint = new int{};
}

Integer::Integer(int value)
{
	std::cout << "\n parameterized constructor  (value) ";
	m_pint = new int{ value };
}

Integer::Integer(const Integer& obj)
{
	std::cout << "\n copy constructor  (&obj  )";
	m_pint = new int{ *obj.m_pint };
}

Integer::Integer(Integer&& obj)
{
	std::cout << "\n move constructor   (&&obj)  ";
	m_pint = obj.m_pint;
	obj.m_pint = nullptr;
}

Integer Integer::operator+(const Integer& obj) const
{
	std::cout << "\n operator + function callled ";
	return Integer(*m_pint + *obj.m_pint);
}

Integer& Integer::operator++()
{
	std::cout << "\n Pre incement operator ++ called";
	++(* m_pint);
	return *this;
}

Integer Integer::operator++(int)
{
	Integer tmp(*this);
	++(*m_pint);
	return tmp;
}

int Integer::getval() const
{
	return *m_pint;
}

void Integer::setval(int value)
{
	if (m_pint == nullptr)
		m_pint = new int{};
	*m_pint = value;
}

bool Integer::operator==(const Integer& obj) const
{
	if (*m_pint == *obj.m_pint)
		return true;
	return false;
}

Integer& Integer::operator=(Integer& obj)
{
	std::cout << "\n assigment operator implrmrnted  = " ;
	if (this != &obj)
	{
		delete m_pint;
		m_pint = new int{ *obj.m_pint };
	}
	return *this;
	// TODO: insert return statement here
}

Integer& Integer::operator=(Integer&& obj)
{
	std::cout << "\n assigment&& move  operator implrmrnted  = ";
	if (this != &obj)
	{
		delete m_pint;
		m_pint = obj.m_pint;
		obj.m_pint = nullptr;
	}
	return *this;
	
}

Integer::~Integer()
{
	std::cout << "\n Destructor Integer () ";
}

smart::smart():p{new Integer{}}
{
    std::cout << "\n default constructor smmart ()";
}

smart::~smart()
{
    std::cout << "\n Destructor smart () ";
    delete p;
}

void smart::set(int val)
    {
        p->setval(val);
    }
void smart::get()
    {
        std::cout<<"\n value = "<<p->getval();
    }