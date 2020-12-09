//
//  dynamic_lib.cpp
//  dynamic_lib
//
//  Created by stl on 2020/12/8.
//

#include <iostream>
#include "dynamic_lib.hpp"
#include "dynamic_libPriv.hpp"

void dynamic_lib::HelloWorld(const char * s)
{
    dynamic_libPriv *theObj = new dynamic_libPriv;
    theObj->HelloWorldPriv(s);
    delete theObj;
};

void dynamic_libPriv::HelloWorldPriv(const char * s) 
{
    std::cout << s << std::endl;
};

