#include <stdio.h>

#include "udp_client.h"

UDPClient::UDPClient()
{

}

UDPClient::~UDPClient()
{

}

bool UDPClient::InitClient()
{
    wVersionRequested = MAKEWORD(1, 1);

    err = WSAStartup(wVersionRequested, &wsaData);
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

void UDPClient::Run()
{
    printf("Client is operating!\n\n");
    //创建用于监听的套接字
    SOCKET sockSrv = socket(AF_INET, SOCK_DGRAM, 0);

    sockaddr_in addrSrv;
    addrSrv.sin_addr.S_un.S_addr = inet_addr("127.0.0.1"); //输入你想通信的她（此处是本机内部）
    addrSrv.sin_family = AF_INET;
    addrSrv.sin_port = htons(11100);

    int len = sizeof(SOCKADDR);

    char recvBuf[100]; //收
    char sendBuf[100]; //发
    char tempBuf[100]; //存储中间信息数据

    memset(recvBuf, '\0', 100);
    memset(sendBuf, '\0', 100);
    memset(tempBuf, '\0', 100);

    while (1)
    {

        printf("Please input data: \n");
        gets_s(sendBuf);
        sendto(sockSrv, sendBuf, strlen(sendBuf) + 1, 0, (SOCKADDR*)&addrSrv, len);
        //等待并数据
        recvfrom(sockSrv, recvBuf, 100, 0, (SOCKADDR*)&addrSrv, &len);
        if ('\0' == recvBuf[0]) {
            printf("ERROR: Didn't receive the data. \n\n");
            Sleep(100);
            continue;
        }
            
        if ('q' == recvBuf[0])
        {
            sendto(sockSrv, "q", strlen("q") + 1, 0, (SOCKADDR*)&addrSrv, len);
            printf("Chat end!\n");
            break;
        }
        sprintf_s(tempBuf, "[%s]Server say : %s", inet_ntoa(addrSrv.sin_addr), recvBuf);
        printf("%s\n", tempBuf);

        //发送数据
    }
    closesocket(sockSrv);
    WSACleanup();
}
