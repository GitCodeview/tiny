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

    if (LOBYTE(wsaData.wVersion) != 1 || //���ֽ�Ϊ���汾
        HIBYTE(wsaData.wVersion) != 1)   //���ֽ�Ϊ���汾
    {
        WSACleanup();
        return false;
    }
	return true;
}

void UDPClient::Run()
{
    printf("Client is operating!\n\n");
    //�������ڼ������׽���
    SOCKET sockSrv = socket(AF_INET, SOCK_DGRAM, 0);

    sockaddr_in addrSrv;
    addrSrv.sin_addr.S_un.S_addr = inet_addr("127.0.0.1"); //��������ͨ�ŵ������˴��Ǳ����ڲ���
    addrSrv.sin_family = AF_INET;
    addrSrv.sin_port = htons(11100);

    int len = sizeof(SOCKADDR);

    char recvBuf[100]; //��
    char sendBuf[100]; //��
    char tempBuf[100]; //�洢�м���Ϣ����

    memset(recvBuf, '\0', 100);
    memset(sendBuf, '\0', 100);
    memset(tempBuf, '\0', 100);

    while (1)
    {

        printf("Please input data: \n");
        gets_s(sendBuf);
        sendto(sockSrv, sendBuf, strlen(sendBuf) + 1, 0, (SOCKADDR*)&addrSrv, len);
        //�ȴ�������
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

        //��������
    }
    closesocket(sockSrv);
    WSACleanup();
}
