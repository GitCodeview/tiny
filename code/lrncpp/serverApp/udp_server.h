#pragma once

#define _WINSOCK_DEPRECATED_NO_WARNINGS
#pragma comment( lib, "ws2_32.lib"  )

#include <Winsock2.h>
#include <string>

#include "constant.h"

class UDPServer
{
public:
    UDPServer();
    ~UDPServer();

    bool InitServer();

    void Run();
    // receive and send message
    bool RecvMsg(std::string& receive_msg);
    bool SendMsg(const std::string send_msg);

private:
    int socket_addr_len;
    char receive_buff[MAX_BUFF_SIZE];
    char send_buff[MAX_BUFF_SIZE];

    SOCKET server_socket;
    // Server ���ͺͽ������ݰ��ĵ�ַ��Ϣ
    SOCKADDR_IN server_addr;
    // client �ĵ�ַ��Ϣ
    SOCKADDR_IN client_addr;

};

