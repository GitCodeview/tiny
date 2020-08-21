#include "restartExe.h"

#include <Windows.h>

void restartExe::restart()
{
    HMODULE exe_module = GetModuleHandle(L"runExeApp.exe");
    if (exe_module) {
        typedef void(__cdecl* ClearBreakpadPipeEnvVar)();
        ClearBreakpadPipeEnvVar clear = reinterpret_cast<ClearBreakpadPipeEnvVar>(
            GetProcAddress(exe_module, "ClearBreakpadPipeEnvironmentVariable"));
        if (clear)
            clear();
    }
}