

#include "udp_server.h"

#include <stdio.h>
#include <iostream>


UDPServer::UDPServer() {
    socket_addr_len = sizeof(SOCKADDR);
    memset(receive_buff, '\0', MAX_BUFF_SIZE);
    memset(send_buff, '\0', MAX_BUFF_SIZE);
}

UDPServer::~UDPServer() {
    closesocket(server_socket);
    WSACleanup();
}

bool UDPServer::InitServer() {
    WORD wVersionRequested;
    WSADATA wsaData;
    int err = 0;

    wVersionRequested = MAKEWORD(1, 1);

    err = WSAStartup(wVersionRequested, &wsaData); //错误会返回WSASYSNOTREADY
    if (err != 0)
    {
        return false;
    }

    if (LOBYTE(wsaData.wVersion) != 1 || //低字节为主版本
        HIBYTE(wsaData.wVersion) != 1)   //高字节为副版本
    {
        WSACleanup();
        return false;
    }
    //创建用于监听的套接字
    server_socket = socket(AF_INET, SOCK_DGRAM, 0);
    //失败会返回 INVALID_SOCKET
    //printf("Failed. Error Code : %d",WSAGetLastError())//显示错误信息

    int timeout = 5000; // timeout millseconds
    setsockopt(server_socket, SOL_SOCKET, SO_RCVTIMEO, (char*)&timeout, sizeof(timeout));

    //定义server发送和接收数据包的地址
    server_addr.sin_addr.S_un.S_addr = htonl(INADDR_ANY);
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(11100);

    //绑定套接字, 绑定到端口
    bind(server_socket, (SOCKADDR*)&server_addr, socket_addr_len);
    //将套接字设为监听模式， 准备接收客户请求
    return true;
}

bool UDPServer::RecvMsg(std::string& receive_msg) {
    int err =recvfrom(server_socket, receive_buff, MAX_BUFF_SIZE, 0,
        (SOCKADDR*)&client_addr, &socket_addr_len);
    if (err == SOCKET_ERROR) {
        std::cout << "[@LT]" << "(UDPServer) Receive message failed."
            << "recvfrom failed with error " << WSAGetLastError()<< std::endl;

        if (WSAGetLastError() == WSAETIMEDOUT) {
            std::cout << "Time out " << WSAGetLastError() << std::endl;
        }
        return false;
    }
    if ('\0' == receive_buff[0]) {
        std::cout << "[@LT]"
            << "Didn't receive the data.";
        return false;
    }
    receive_msg = receive_buff;
    return true;
}
bool UDPServer::SendMsg(const std::string send_msg) {
    memcpy(send_buff, send_msg.c_str(), send_msg.size());
    sendto(server_socket, send_buff, strlen(send_buff), 0,
        (SOCKADDR*)&client_addr, socket_addr_len);
    return true;
}

void UDPServer::Run()
{
    printf("server is operating!\n\n");
    std::string receive_msg, send_msg = "Received Successfully.";
    while (true)
    {
        if (RecvMsg(receive_msg)) {
            std::cout << "Client Say: "<< receive_msg << std::endl;
            SendMsg(send_msg);
        }
    }
}