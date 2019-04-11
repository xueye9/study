#include "statis_test1.h"
#include <iostream>



StaticTest::StaticTest()
{
    g_i = 1;
    std::cout << "static1:" << g_i << std::endl;
}

StaticTest::~StaticTest()
{
}
