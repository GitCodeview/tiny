//
//  main.cpp
//  console_lib_test
//
//  Created by stl on 2020/12/8.
//

#include <iostream>

#include "../dynamic_lib/dynamic_lib/dynamic_lib.hpp"
#include "../static_lib/static_lib/static_lib.hpp"

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n\n";
    
    dynamic_lib::HelloWorld("dynamic_lib: Hello, World!\n");
    static_lib::HelloWorld("static_lib: Hello, World!\n");
    
    return 0;
}
