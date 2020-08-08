using System;
using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json;
using System.Text.Json;
namespace consoleApp
{
    [Serializable]
    public class Configuration
    {
        public string version;

        public List<Server> configs;

        // when strategy is set, index is ignored
        public string strategy;
        public int index;
        public bool global;
        public bool enabled;
        public bool shareOverLan;
        public bool isDefault;
        public bool isIPv6Enabled = false;
        public int localPort;
        public bool portableMode = true;
        public string pacUrl;
        public bool useOnlinePac;
        public bool secureLocalPac = true;
        public bool availabilityStatistics;
        public bool autoCheckUpdate;
        public bool checkPreRelease;
        public bool isVerboseLogging;

        private static readonly string CONFIG_FILE = "gui-config.json";
        private static string CONFIG_TEMPLATE = @"{
                                                    'version': '4.1.8.0',
                                                    'configs': __SERVERLIST__,
                                                    'strategy': 'com.shadowsocks.strategy.statistics',
                                                    'index': -1,
                                                    'global': false,
                                                    'enabled': true,
                                                    'shareOverLan': false,
                                                    'isDefault': false,
                                                    'isIPv6Enabled': false,
                                                    'localPort': 1080,
                                                    'portableMode': true,
                                                    'pacUrl': null,
                                                    'useOnlinePac': false,
                                                    'secureLocalPac': false,
                                                    'availabilityStatistics': true,
                                                    'autoCheckUpdate': false,
                                                    'checkPreRelease': false,
                                                    'isVerboseLogging': true
                                                  }";
        [JsonIgnore]
        public string localHost => GetLocalHost();
        private string GetLocalHost() {
            return isIPv6Enabled ? "[::1]" : "127.0.0.1";
        }
        public Server GetCurrentServer()
        {
            if (index >= 0 && index < configs.Count)
                return configs[index];
            else
                return GetDefaultServer();
        }

        public static void CheckServer(Server server)
        {
            CheckServer(server.server);
            CheckPort(server.server_port);
            CheckPassword(server.password);
            CheckTimeout(server.timeout, Server.MaxServerTimeoutSec);
        }

        public static bool ChecksServer(Server server)
        {
            try
            {
                CheckServer(server);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static string GetServerListJson()
        {
            //string original = "Here is some data to encrypt!";
            string newBID = GUIDTest.GenerateBID(); // Generate bid
            Console.WriteLine("BID: {0}", newBID);
            string encryptedBID = AESTest.Encrypt(newBID); // Encrypt bid.
            Console.WriteLine("Encrypted BID: {0}", encryptedBID);
            var url = "http://120.24.168.112:31001/web/acceleration/findAccelerationInfo";
            // var url = "http://120.24.168.112:31001/web/acceleration/findWhiteList";
            var responseJsonText = HttpClient.DownloadStringWithBid(url, encryptedBID);
            JSONTest JsonObj = new JSONTest(responseJsonText);
            JsonElement root = JsonObj.GetRoot();
            JsonElement bodyMessageElement = root.GetProperty("bodyMessage");
            string base64encrypted = bodyMessageElement.GetString();
            File.WriteAllBytes(".sl",Convert.FromBase64String(base64encrypted));
            return AESTest.Decrypt(base64encrypted);
        }

        public static Configuration Load()
        {
            try
            {
                //string configContent = File.ReadAllText(CONFIG_FILE);
                string serverListJson = GetServerListJson();
                string configContent = CONFIG_TEMPLATE.Replace("__SERVERLIST__", serverListJson);
                Configuration config = JsonConvert.DeserializeObject<Configuration>(configContent);
                config.isDefault = false;

                if (config.configs == null)
                    config.configs = new List<Server>();
                if (config.configs.Count == 0)
                    config.configs.Add(GetDefaultServer());
                if (config.localPort == 0)
                    config.localPort = 1080;
                if (config.index == -1 && config.strategy == null)
                    config.index = 0;
                if (!System.Net.Sockets.Socket.OSSupportsIPv6) {
                    config.isIPv6Enabled = false; // disable IPv6 if os not support
                }
                //TODO if remote host(server) do not support IPv6 (or DNS resolve AAAA TYPE record) disable IPv6?

                return config;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return new Configuration
                {
                    index = 0,
                    isDefault = true,
                    localPort = 1080,
                    autoCheckUpdate = true,
                    configs = new List<Server>()
                    {
                        GetDefaultServer()
                    },
                };
            }
        }

        public static void Save(Configuration config)
        {

            if (config.index >= config.configs.Count)
                config.index = config.configs.Count - 1;
            if (config.index < -1)
                config.index = -1;
            if (config.index == -1 && config.strategy == null)
                config.index = 0;
            config.isDefault = false;
            try
            {
                using (StreamWriter sw = new StreamWriter(File.Open(CONFIG_FILE, FileMode.Create)))
                {
                    string jsonString = JsonConvert.SerializeObject(config, Formatting.Indented);
                    sw.Write(jsonString);
                    sw.Flush();
                }
            }
            catch (IOException e)
            {
                //Logging.LogUsefulException(e);
                Console.WriteLine(e.Message);
            }
        }

        public static Server AddDefaultServerOrServer(Configuration config, Server server = null, int? index = null)
        {
            if (config != null && config.configs != null)
            {
                server = (server ?? GetDefaultServer());

                config.configs.Insert(index.GetValueOrDefault(config.configs.Count), server);

                //if (index.HasValue)
                //    config.configs.Insert(index.Value, server);
                //else
                //    config.configs.Add(server);
            }
            return server;
        }

        public static Server GetDefaultServer()
        {
            return new Server();
        }

        private static void Assert(bool condition)
        {
            if (!condition)
                throw new Exception(("assertion failure"));
        }

        public static void CheckPort(int port)
        {
            if (port <= 0 || port > 65535)
                throw new ArgumentException(("Port out of range"));
        }

        public static void CheckLocalPort(int port)
        {
            CheckPort(port);
            if (port == 8123)
                throw new ArgumentException(("Port can't be 8123"));
        }

        private static void CheckPassword(string password)
        {
            if (String.IsNullOrEmpty(password))
                throw new ArgumentException(("Password can not be blank"));
        }

        public static void CheckServer(string server)
        {
            if (String.IsNullOrEmpty(server))
                throw new ArgumentException(("Server IP can not be blank"));
        }

        public static void CheckTimeout(int timeout, int maxTimeout)
        {
            if (timeout <= 0 || timeout > maxTimeout)
                throw new ArgumentException(
                    ("Timeout is invalid, it should not exceed ")+ maxTimeout.ToString());
        }

        public static void CheckProxyAuthUser(string user)
        {
            if (String.IsNullOrEmpty(user))
                throw new ArgumentException(("Auth user can not be blank"));
        }

        public static void CheckProxyAuthPwd(string pwd)
        {
            if (String.IsNullOrEmpty(pwd))
                throw new ArgumentException(("Auth pwd can not be blank"));
        }
    }
}
