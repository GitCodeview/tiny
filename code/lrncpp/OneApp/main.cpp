#include <iostream>

#include "tcp_server.h"

#include "tcp_client.h"

DWORD WINAPI ThreadTCPServer(LPVOID lpParamter)
{
    TCPServerMain();

    return 0L;
}


int main(int argc, char** argv) {

	//HANDLE hThreadTCPServer = CreateThread(NULL, 0, ThreadTCPServer, NULL, 0, NULL);

	TCPClientMain(argc, argv);

	//CloseHandle(hThreadTCPServer);

	return 0;
}