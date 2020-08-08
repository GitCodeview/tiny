#pragma once

#define _WINSOCK_DEPRECATED_NO_WARNINGS
#pragma comment( lib, "ws2_32.lib"  )

#include <Winsock2.h>

class UDPServer
{
public:
    UDPServer();
    ~UDPServer();

    bool InitServer();

    void Run();

private:
    WORD wVersionRequested;
    WSADATA wsaData;
    int err;
};

