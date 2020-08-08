#include <stdio.h>
#include "udp_server.h"

UDPServer::UDPServer()
{
}

UDPServer::~UDPServer()
{
}

bool UDPServer::InitServer()
{
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
	return true;
}

void UDPServer::Run()
{
    printf("server is operating!\n\n");
    //创建用于监听的套接字
    SOCKET sockSrv = socket(AF_INET, SOCK_DGRAM, 0); //失败会返回 INVALID_SOCKET
    //printf("Failed. Error Code : %d",WSAGetLastError())//显示错误信息

    SOCKADDR_IN addrSrv; //定义sockSrv发送和接收数据包的地址
    addrSrv.sin_addr.S_un.S_addr = htonl(INADDR_ANY);
    addrSrv.sin_family = AF_INET;
    addrSrv.sin_port = htons(11100);

    //绑定套接字, 绑定到端口
    bind(sockSrv, (SOCKADDR*)&addrSrv, sizeof(SOCKADDR)); //会返回一个SOCKET_ERROR
    //将套接字设为监听模式， 准备接收客户请求

    SOCKADDR_IN addrClient; //用来接收客户端的地址信息
    
    int len = sizeof(SOCKADDR);
    char recvBuf[100]; //收
    char sendBuf[100]; //发
    char tempBuf[100]; //存储中间信息数据

    memset(recvBuf, '\0', 100);
    memset(sendBuf, '\0', 100);
    memset(tempBuf, '\0', 100);

    while (1)
    {

        //等待并数据
        recvfrom(sockSrv, recvBuf, 100, 0, (SOCKADDR*)&addrClient, &len);
        if ('\0' == recvBuf[0]) {
            printf(" Didn't receive the data in 100 milliseconds. \n\n");
            Sleep(100);
            continue;
        }
        if ('q' == recvBuf[0])
        {
            sendto(sockSrv, "q", strlen("q") + 1, 0, (SOCKADDR*)&addrClient, len);
            printf("Chat end!\n");
            break;
        }
        sprintf_s(tempBuf, "[%s]Client say : %s", inet_ntoa(addrClient.sin_addr), recvBuf);
        printf("%s\n", tempBuf);

        //发送数据
        //printf("Please input data: \n");
        //gets_s(sendBuf);
        memcpy(sendBuf, "Success Received.", 18);
        sendto(sockSrv, sendBuf, strlen(sendBuf) + 1, 0, (SOCKADDR*)&addrClient, len);
    }
    closesocket(sockSrv);
    WSACleanup();
}
