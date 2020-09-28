
#encoding:utf-8
'''
Created on 2015年10月10日
@author: ZHOUMEIXU204
'''
 
import os
import  time
 
 
#第一种
print(u'测试开始')
os.system('dir')
os.system('ping 192.168.1.1')
print(u'测试结束')
 
 
#第二种
import  subprocess
 
print(u'测试开始')
subprocess.Popen('dir',shell=True)
subprocess.Popen('ping 192.168.1.1',shell=True)
print(u'测试结束')

# F:\chromium-stl\src\third_party\lzma_sdk\Executable\7za.exe x -oF:\chromium-stl\src\out\release\gen\chrome\installer\mini_installer\mini_installer\temp_installer_archive\ E:/Temp/base\chrome.7z Chrome-bin/*/chrome.dll
# E:\chromium-stl\src\third_party\lzma_sdk\Executable\7za.exe