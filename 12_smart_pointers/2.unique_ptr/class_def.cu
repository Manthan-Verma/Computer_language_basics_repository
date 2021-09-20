#include"unique.cuh"

Integer::Integer()
{
	std::cout << "\n default constructor ";
	m_pint = new int{};
}

Integer::Integer(int val)
{
	std::cout << "\n constructor int val ";
	m_pint = new int{ val };
}

Integer::Integer(const Integer& obj)
{
	std::cout << "\n copy constructor &";
	m_pint = new int{ *obj.m_pint };
}

Integer::Integer(Integer&& obj)
{
	std::cout << "\n copy constructor &&";
	m_pint = obj.m_pint;
	std::cout << "\t data = " << *obj.m_pint;
	obj.m_pint = nullptr;
}

Integer Integer::operator = (int val)
{
    delete m_pint;
    m_pint = new int{val};
    return *this;
}
void Integer::setvalue(int value)
{
	//std::cout << "\n wowowow!!!!!!!!";
	*m_pint = value;
}

int Integer::getvalue() const
{
	return *m_pint;
}

Integer::~Integer()
{
	std::cout << "\n Destructor ()";
}