#include "regedit_test.h"


#include <windows.h>
#include <malloc.h>
#include <stdio.h>
#include <wchar.h>
#include <string>

void RegeditTest::TestMain()
{
    // ��ȡ����ԱȨ�ޣ�
    // ����Ŀ-��Ŀ����-������-�嵥�ļ�-UACִ�м����޸�Ϊ
    // requireAdministrator (/level='requireAdministrator')�������м��ɡ�

    HKEY key_;  // The registry key being iterated.
    LPCWSTR versionPath = L"SOFTWARE\\WOW6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\iChoice";
    REGSAM access = (KEY_WRITE | KEY_WOW64_64KEY);

    long ret = RegOpenKeyEx(HKEY_LOCAL_MACHINE, versionPath, 0, access, &key_);
    if (ret != ERROR_SUCCESS)//����޷���hKEY,����ֹ�����ִ��
    {
        printf("Open ERRO!");
    }


    std::wstring wstrVersion(L"1.0.3.5");
    LPCWSTR name = L"DisplayVersion";
    LPBYTE lpValue = reinterpret_cast<LPBYTE>(
                        const_cast<wchar_t*>(wstrVersion.c_str()));
    DWORD dsize = static_cast<DWORD>(wstrVersion.size()*sizeof(wchar_t)+1);
    DWORD dtype = REG_SZ;
    LONG result = RegSetValueEx(key_, name, 0, dtype, lpValue, dsize);
    if (result != ERROR_SUCCESS) {
        printf("Set ERRO!");
        RegCloseKey(key_);
    }
}