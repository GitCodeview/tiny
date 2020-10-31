#include "tcp_server.h"

TCPServer::TCPServer()
{
    listen_socket = INVALID_SOCKET;
}

TCPServer::~TCPServer()
{
}

bool TCPServer::InitServer()
{
    return false;
}

void TCPServer::Run()
{
}

bool TCPServer::RecvMsg(std::string& receive_msg)
{
    return false;
}

bool TCPServer::SendMsg(const std::string send_msg)
{
    return false;
}
