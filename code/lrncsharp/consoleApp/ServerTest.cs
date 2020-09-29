using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;

namespace consoleApp
{
    class ServerTest
    {
        public static Server FindOtherBestServer(Server curServer)
        {
            if( ServerList.servers != null)
            {
                var Servers = new List<Server>(ServerList.servers);
                Servers.Remove(curServer);// remove current server
                int timeoutProxyCntMin = 
                    Servers.Aggregate(
                        (server1, server2) => 
                            server1.timeoutProxyCnt < server2.timeoutProxyCnt ?  
                            server1 : server2).timeoutProxyCnt;
                var bestServers = Servers.FindAll(server => server.timeoutProxyCnt == timeoutProxyCntMin);
                Console.WriteLine("All Servers:");
                ServerList.servers.ForEach(server => Console.WriteLine("{0} - {1}", server.server, server.timeoutProxyCnt));
                Console.WriteLine("All Servers End.\n");
                Console.WriteLine("Current Server: {0} - {1}\n", curServer.server, curServer.timeoutProxyCnt);
                Console.WriteLine("All other Servers:");
                Servers.ForEach(server => Console.WriteLine("{0} - {1}", server.server, server.timeoutProxyCnt));
                Console.WriteLine("All other Servers End.\n");
                Console.WriteLine("Best Servers:");
                bestServers.ForEach(server => Console.WriteLine("{0} - {1}", server.server, server.timeoutProxyCnt));
                Console.WriteLine("Best Servers End.\n");
                int index;
                index = new Random().Next() % bestServers.Count;
                Server bestServer = bestServers[index];
                Console.WriteLine("Best Server: {0} - {1}\n", bestServer.server, bestServer.timeoutProxyCnt);
                return bestServer;
            }

            return new Server();
        }

        public static Server ChooseBestServer()
        {
            int index;
            ServerList.LoadServers();
            index = (new Random().Next()) % (ServerList.servers.Count);
            Server curServer = ServerList.servers[index];
            return FindOtherBestServer(curServer);
        }
    }
}
