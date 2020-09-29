using System;
using System.Collections.Generic;
using System.Text;

namespace consoleApp
{
    class ServerList
    {
        public static List<Server> servers;

        public static void LoadServers()
        {
            string serversJson = @"[{
                                'server': '94.176.237.206',
                                'server_port': 21647,
                                'password': 'iosDevPwd123',
                                'method': 'rc4-md5',
                                'plugin': '',
                                'plugin_opts': '',
                                'plugin_args': '',
                                'remarks': '',
                                'timeout': 5,
                                'timeoutProxyCnt': 2
                            },
                            {
                                'server': '47.74.226.204',
                                'server_port': 8383,
                                'password': 'xx123456',
                                'method': 'rc4-md5',
                                'plugin': '',
                                'plugin_opts': '',
                                'plugin_args': '',
                                'remarks': '新加坡',
                                'timeout': 5,
                                'timeoutProxyCnt': 1
                            },
                            {
                                'server': '47.245.55.21',
                                'server_port': 8383,
                                'password': 'xx123456',
                                'method': 'rc4-md5',
                                'plugin': '',
                                'plugin_opts': '',
                                'plugin_args': '',
                                'remarks': '日本',
                                'timeout': 5,
                                'timeoutProxyCnt': 2
                            },
                            {
                                'server': '47.56.125.154',
                                'server_port': 8383,
                                'password': 'xx123456',
                                'method': 'rc4-md5',
                                'plugin': '',
                                'plugin_opts': '',
                                'plugin_args': '',
                                'remarks': '香港',
                                'timeout': 5,
                                'timeoutProxyCnt': 3
                            },
                            {
                                'server': '47.74.84.133',
                                'server_port': 8383,
                                'password': 'xx123456',
                                'method': 'rc4-md5',
                                'plugin': '',
                                'plugin_opts': '',
                                'plugin_args': '',
                                'remarks': '澳大利亚',
                                'timeout': 5,
                                'timeoutProxyCnt': 3
                            },
                            {
                                'server': '47.254.27.235',
                                'server_port': 8383,
                                'password': 'xx123456',
                                'method': 'rc4-md5',
                                'plugin': '',
                                'plugin_opts': '',
                                'plugin_args': '',
                                'remarks': '美国硅谷',
                                'timeout': 5,
                                'timeoutProxyCnt': 4
                            },
                            {
                                'server': '8.208.76.156',
                                'server_port': 8383,
                                'password': 'xx123456',
                                'method': 'rc4-md5',
                                'plugin': '',
                                'plugin_opts': '',
                                'plugin_args': '',
                                'remarks': '英国伦敦',
                                'timeout': 5,
                                'timeoutProxyCnt': 6
                            }]";
        }
    }
}
