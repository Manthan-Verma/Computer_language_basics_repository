#include<iostream>
#include<memory>
#include<algorithm>

class Printer
{
private:
    int *m_pvalue{};
public:
    void setval(int *p)
    {
        m_pvalue = p;
    }
    void print() const{
        std::cout<<"\n value is : "<<*m_pvalue<<std::endl;
    }
};

class Printer_shared
{
private:
    std::shared_ptr<int> m_pvalue{};
public:
    void setval(std::shared_ptr<int> p)
    {
        m_pvalue = p;
    }
    void print() const{
        std::cout<<"\n value is : "<<*m_pvalue<<std::endl;
    }
};

class Printer_weak
{
private:
    std::weak_ptr<int> m_pvalue{};
public:
    void setval(std::weak_ptr<int> p)
    {
        m_pvalue = p;
    }
    void print() const{
    if(m_pvalue.expired())
    {
        std::cout<<"\n Memory is freed ";
        return;
    }
    auto sp = m_pvalue.lock();
    std::cout<<"\n value is : "<<*sp<<std::endl;
    }
};