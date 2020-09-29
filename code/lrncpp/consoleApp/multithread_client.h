#pragma once

class MultithreadClient
{
public:
    MultithreadClient();
    ~MultithreadClient();

    bool InitClient();

    void Run();

private:
    int err;
};

