#pragma once

#ifndef UNICODE
#define UNICODE
#endif

#define WIN32_LEAN_AND_MEAN

#define _WINSOCK_DEPRECATED_NO_WARNINGS

#include <winsock2.h>
#include <Ws2tcpip.h>
#include <stdio.h>

#include <string>


// Link with ws2_32.lib
#pragma comment(lib, "Ws2_32.lib")

class UDPTest
{
public:
	static int UDPSendtoTest(const std::string send_msg);
	static int UDPRecvfromTest(std::string& receive_msg);
};