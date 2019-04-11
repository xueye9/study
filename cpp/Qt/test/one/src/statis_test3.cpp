#include "statis_test3.h"
#include "statis_test1.h"
#include <iostream>
                                
StaticTest3::StaticTest3()
{ 
    std::cout << "static3:" << g_i << std::endl;
}

StaticTest3::~StaticTest3()
{
}
