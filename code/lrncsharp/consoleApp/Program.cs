using System;

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

            AESTest.MainTest();

            // BID Generation and Encryption
            //string newBID = GUIDTest.GenerateBID();
            //Console.WriteLine(newBID);
            //string encryptedNewBID = AESTest.Encrypt(newBID);
            //Console.WriteLine(encryptedNewBID);

            //Configuration config = Configuration.Load();
            //Configuration.Save(config);

        }
    }
}
