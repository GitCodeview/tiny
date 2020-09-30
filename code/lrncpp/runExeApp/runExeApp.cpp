// runExeApp.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>

#include <stdio.h>
#include <string>
#include <windows.h>
#pragma comment(lib,"Kernel32.lib")

#include "restartExe.h"


int main()
{
    std::cout << "Hello World!\n";

    //LCID lcid = GetSystemDefaultLCID();
    //switch (lcid)
    //{
    //case 0x0804:
    //    printf("ch-CN\n");
    //    break;
    //case 0x0404:
    //    printf("ch-TW\n");
    //    break;
    //case 0x0409:
    //    printf("en\n");
    //    break;
    //}
    //char chtext = char(0x26);
    //char ch_str[10];
    //sprintf_s(ch_str, "%c%s", chtext, "test");
    //std::string result(ch_str);
    //std::string result_tmp = ch_str;
    //std::string str_tmp = "\x26";
    //std::cout << result << "   \n"
    //          << result_tmp +" test" << "   \n" 
    //          << ch_str << "   \n"
    //          << str_tmp + " test" << "   \n"
    //          << std::endl;

    //bool bcpy = MoveFileEx(
    //    (LPCWSTR)("E:\\github\\tiny\\code\\lrncpp\\Debug\\test"), 
    //    (LPCWSTR)("E:\\github\\tiny\\code\\lrncpp\\Debug\\test_00"),0);
    //std::cout << bcpy << std::endl;

    //std::string msg;

    //while (true)
    //{
    //    std::cout << "Please enter the message:\n";
    //    std::cin >> msg;
    //    std::cout << "The Message is: " << msg << std::endl;
    //    if (msg == ":re")
    //    {
    //        std::cout << "restarting... "<< std::endl;
    //        restartExe::restart();
    //        break;
    //    }
    //}


    
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
