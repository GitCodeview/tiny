#pragma once

#define _WINSOCK_DEPRECATED_NO_WARNINGS
#pragma comment( lib, "ws2_32.lib"  )

#include <Winsock2.h>


class UDPClient
{
 public:
     UDPClient();
     ~UDPClient();

     bool InitClient();

     void Run();

 private:
    WORD wVersionRequested;
    WSADATA wsaData;
    int err;
};

