// serverApp.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>

#include "udp_server.h"
#include "udp_test.h"

DWORD WINAPI ThreadRecvfrom(LPVOID lpParamter)
{
    std::string receive_msg;
    Sleep(100);
    while (receive_msg != ":q")
    {
        UDPTest::UDPRecvfromTest(receive_msg);
        std::cout << " Received Msg: " << receive_msg;
    }

    return 0L;
}

DWORD WINAPI ThreadSendto(LPVOID lpParamter)
{
    std::string send_msg = "Hello!";
    Sleep(100);
    for (int i = 0; i < 10; i++)
    {
        UDPTest::UDPSendtoTest(send_msg);
        std::cout << "[" << i <<"] Sent Msg: " << send_msg ;
    }
    UDPTest::UDPSendtoTest(":q");
    return 0L;
}

int main()
{
    std::cout << "Hello World!\n";

    //HANDLE hThreadRecvfrom = CreateThread(NULL, 0, ThreadRecvfrom, NULL, 0, NULL);
    //HANDLE hThreadSendto = CreateThread(NULL, 0, ThreadSendto, NULL, 0, NULL);

    UDPServer local_server = UDPServer();
    if (local_server.InitServer())
        local_server.Run();

    //CloseHandle(hThreadRecvfrom);
    //CloseHandle(hThreadSendto);
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
