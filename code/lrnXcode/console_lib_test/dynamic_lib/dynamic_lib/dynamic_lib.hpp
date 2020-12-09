//
//  dynamic_lib.hpp
//  dynamic_lib
//
//  Created by stl on 2020/12/8.
//

#ifndef dynamic_lib_
#define dynamic_lib_

/* The classes below are exported */
#pragma GCC visibility push(default)

class dynamic_lib
{
    public:
    static void HelloWorld(const char *);
};

#pragma GCC visibility pop
#endif
