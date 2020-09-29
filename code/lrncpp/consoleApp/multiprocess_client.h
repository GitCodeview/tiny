#pragma once
class MultiprocessClient
{
public:
    MultiprocessClient();
    ~MultiprocessClient();

    bool InitClient();

    void Run();

private:
    int err;
};

