#pragma once

#undef UNICODE

#define WIN32_LEAN_AND_MEAN

#include <windows.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <stdlib.h>
#include <stdio.h>

#include <string>
#include <list>

// Need to link with Ws2_32.lib
#pragma comment (lib, "Ws2_32.lib")
// #pragma comment (lib, "Mswsock.lib")

#include "constant.h"

class TCPServer
{
 public:
	TCPServer();
	~TCPServer();

    bool InitServer();

    void Run();
    // receive and send message
    bool RecvMsg(std::string& receive_msg);
    bool SendMsg(const std::string send_msg);

 private:
    int socket_addr_len;
    char receive_buff[MAX_BUFF_SIZE];
    char send_buff[MAX_BUFF_SIZE];

    SOCKET listen_socket;
    std::list<SOCKET*> client_socket_list;

};

