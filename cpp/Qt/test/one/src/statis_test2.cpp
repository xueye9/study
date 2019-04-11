#include "statis_test2.h"
#include "statis_test1.h"
#include <iostream>
                                
StaticTest2::StaticTest2()
{ 
    g_i = 2;
    std::cout << "static2:" << g_i << std::endl;
}

StaticTest2::~StaticTest2()
{
}
