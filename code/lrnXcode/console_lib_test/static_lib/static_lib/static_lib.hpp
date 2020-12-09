//
//  static_lib.hpp
//  static_lib
//
//  Created by stl on 2020/12/8.
//

#ifndef static_lib_
#define static_lib_

/* The classes below are exported */
#pragma GCC visibility push(default)

class static_lib
{
    public:
    static void HelloWorld(const char *);
};

#pragma GCC visibility pop
#endif
