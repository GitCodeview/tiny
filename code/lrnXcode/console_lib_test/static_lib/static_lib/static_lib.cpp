//
//  static_lib.cpp
//  static_lib
//
//  Created by stl on 2020/12/8.
//

#include <iostream>
#include "static_lib.hpp"
#include "static_libPriv.hpp"

void static_lib::HelloWorld(const char * s)
{
    static_libPriv *theObj = new static_libPriv;
    theObj->HelloWorldPriv(s);
    delete theObj;
};

void static_libPriv::HelloWorldPriv(const char * s) 
{
    std::cout << s << std::endl;
};

