//
//  static_libPriv.hpp
//  static_lib
//
//  Created by stl on 2020/12/8.
//

/* The classes below are not exported */
#pragma GCC visibility push(hidden)

class static_libPriv
{
    public:
    void HelloWorldPriv(const char *);
};

#pragma GCC visibility pop
