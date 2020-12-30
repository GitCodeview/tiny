using System;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;

namespace consoleApp
{
    class ServerList
    {
        public static List<Server> serverList = null;

        public static void LoadServers()
        {
            string serverListJson = @"[{
                                        'server': 'fpn-hk.vpc.kr',
                                        'server_port': 23616,
                                        'password': 'sg123456',
                                        'method': 'aes-256-ctr',
                                        'plugin': '',
                                        'plugin_opts': '',
                                        'plugin_args': '',
                                        'remarks': 'official',
                                        'timeout': 5,
                                        'timeoutProxyCnt': 1
                                    },
                                    {
                                        'server': '161.117.82.252',
                                        'server_port': 8383,
                                        'password': 'sg123456',
                                        'method': 'aes-256-ctr',
                                        'plugin': '',
                                        'plugin_opts': '',
                                        'plugin_args': '',
                                        'remarks': 'release',
                                        'timeout': 5,
                                        'timeoutProxyCnt': 3
                                    },
                                    {
                                        'server': '47.242.13.83',
                                        'server_port': 8383,
                                        'password': 'sg123456',
                                        'method': 'aes-256-gcm',
                                        'plugin': '',
                                        'plugin_opts': '',
                                        'plugin_args': '',
                                        'remarks': 'release',
                                        'timeout': 5,
                                        'timeoutProxyCnt': 3
                                    },
                                    {
                                        'server': '161.117.178.158',
                                        'server_port': 8383,
                                        'password': 'sg123456',
                                        'method': 'aes-256-gcm',
                                        'plugin': '',
                                        'plugin_opts': '',
                                        'plugin_args': '',
                                        'remarks': 'release',
                                        'timeout': 5,
                                        'timeoutProxyCnt': 6
                                    },
                                    {
                                        'server': '161.117.82.109',
                                        'server_port': 8383,
                                        'password': 'sa123456',
                                        'method': 'aes-256-gcm',
                                        'plugin': '',
                                        'plugin_opts': '',
                                        'plugin_args': '',
                                        'remarks': 'release',
                                        'timeout': 5,
                                        'timeoutProxyCnt': 4
                                    },
                                    {
                                        'server': '47.242.9.23',
                                        'server_port': 8383,
                                        'password': 'sg123456',
                                        'method': 'aes-256-gcm',
                                        'plugin': '',
                                        'plugin_opts': '',
                                        'plugin_args': '',
                                        'remarks': 'release',
                                        'timeout': 5,
                                        'timeoutProxyCnt': 4
                                    },
                                    {
                                        'server': '154.204.30.133',
                                        'server_port': 8383,
                                        'password': 'sg123456',
                                        'method': 'aes-256-ctr',
                                        'plugin': '',
                                        'plugin_opts': '',
                                        'plugin_args': '',
                                        'remarks': 'official',
                                        'timeout': 5,
                                        'timeoutProxyCnt': 0
                                    },
                                    {
                                        'server': '154.204.30.131',
                                        'server_port': 8383,
                                        'password': 'sg123456',
                                        'method': 'aes-256-ctr',
                                        'plugin': '',
                                        'plugin_opts': '',
                                        'plugin_args': '',
                                        'remarks': 'official',
                                        'timeout': 5,
                                        'timeoutProxyCnt': 9
                                    },
                                    {
                                        'server': '121.12.172.56',
                                        'server_port': 8383,
                                        'password': 'sg123456',
                                        'method': 'aes-256-ctr',
                                        'plugin': '',
                                        'plugin_opts': '',
                                        'plugin_args': '',
                                        'remarks': 'official',
                                        'timeout': 5,
                                        'timeoutProxyCnt': 1
                                    }]";
            serverList = JsonConvert.DeserializeObject<List<Server>>(serverListJson);
        }
    }
}
