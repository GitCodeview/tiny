using System;
using System.Collections.Specialized;
using System.Threading;

namespace consoleApp
{
    public class Person
    {
        public string FirstName { get; private set; }
        public string LastName { get; private set; }

        public Person(string first, string last)
        {
            FirstName = first;
            LastName = last;
        }

        public override string ToString()
        {
            return FirstName + " " + LastName;
        }

        public string AllCaps()
        {
            return ToString().ToUpper();
        }
    }



    public class Example
    {

        public void StartTimer(int dueTime)
        {
            Timer t = new Timer(new TimerCallback(TimerProc));
            t.Change(dueTime, 0);
        }

        private void TimerProc(object state)
        {
            // The state object is the Timer object.
            Timer t = (Timer)state;
            t.Dispose();
            Console.WriteLine("The timer callback executes.");
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            //var p = new Person("Bill", "Wagner");
            //Console.WriteLine("The name, in all caps: " + p.AllCaps());
            //Console.WriteLine("The name: " + p);

            //var request_url = "http://192.168.2.24:8080/gfwlist.txt";
            //var download_text = HttpClient.DownloadString(request_url);

            //Console.WriteLine(download_text);

            //HttpClient.DownloadStringAsync(request_url);

            //string bid = "SneH/3iH8uqVet/KrNxMXSgcHSzWed7STcCSiYOoie0=";
            //var findAccelerationInfo_url = "http://120.24.168.112:31001/web/acceleration/findAccelerationInfo";
            //var response_text = HttpClient.DownloadStringWithBid(findAccelerationInfo_url, bid);

            //Console.WriteLine(response_text);

            //var findWhiteList_url = "http://120.24.168.112:31001/web/acceleration/findWhiteList";
            //response_text = HttpClient.DownloadStringWithBid(findWhiteList_url, bid);

            //Console.WriteLine(response_text);

            //var file_url = "http://192.168.2.24:8080/gfwlist.txt";
            //var file_name = "gfwlist.txt";

            //HttpClient.DownloadFile(file_url, file_name);

            //AESTest.MainTest();

            // BID Generation and Encryption
            //string newBID = GUIDTest.GenerateBID();
            //Console.WriteLine(newBID);
            //string encryptedNewBID = AESTest.Encrypt(newBID);
            //Console.WriteLine(encryptedNewBID);

            //Configuration config = Configuration.Load();
            //Configuration.Save(config);

            //RunTimer.MainTest();

            // Create an instance of the Example class, and start two
            // timers.
            //Example ex = new Example();
            //ex.StartTimer(2000);
            //ex.StartTimer(1000);

            //Console.WriteLine("Press Enter to end the program.");
            //Console.ReadLine();
            //获取当前想要启动的进程名，进程名不要加后缀： exe
            //string strProcessName = System.Diagnostics.Process.GetCurrentProcess().ProcessName;
            //int ntmp0 = System.Diagnostics.Process.GetProcessesByName(strProcessName).Length;
            //int ntmp1 = System.Diagnostics.Process.GetProcessesByName("iChoice").Length;
            //int ntmp2 = System.Diagnostics.Process.GetProcessesByName("ichoice").Length;
            //Console.WriteLine($"{ntmp0} {ntmp1} {ntmp2}");
            //while (true) 
            //{
            //    int test_port = Convert.ToInt32(Console.ReadLine());
            //    if (PortCheck.PortInUse(test_port))
            //        Console.WriteLine($"{test_port} in using.");
            //    else
            //        Console.WriteLine($"{test_port} NOT in using.");
            //}

            //Console.WriteLine("Environment.SpecialFolder.LocalApplicationData: {0}",
            //     Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData));

            //int count = 0;
            //String strBIDS = GUIDTest.GetEncryptedBID();
            //while (count < 1000)
            //{
            //    strBIDS += ("\n" + GUIDTest.GetEncryptedBID());
            //    count++;
            //}

            //FileTest.Write("BIDS.txt", strBIDS);

            //string quitString = "";
            //RandomTest randomInstance = new RandomTest();
            //while (quitString != ":q")
            //{
            //    randomInstance.DisplayRandomIndexs();
            //    Console.Write("Press any key to continue(Enter :q to quit).\n");
            //    quitString = Console.ReadLine();
            //    //Console.WriteLine("You entered: {0}\n", quitString);
            //}

            string quitString = "";
            while (quitString != ":q")
            {
                ServerTest.ChooseBestServer();
                Console.Write("Press any key to continue(Enter :q to quit).\n");
                quitString = Console.ReadLine();
                //Console.WriteLine("You entered: {0}\n", quitString);
            }
            

        }
    }
}
