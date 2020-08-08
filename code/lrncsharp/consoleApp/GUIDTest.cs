using System;
using System.Collections.Generic;
using System.Text;

namespace consoleApp
{
    class GUIDTest
    {
        public static string GenerateGUID()
        {
            // Create One GUID.
            return Guid.NewGuid().ToString();
        }

        public static string GenerateBID()
        {
            string curentDate = DateTime.UtcNow.ToString("MM-dd-yy-yy");
            Console.WriteLine("Current Date: {0}", curentDate);

            string newGUID = GUIDTest.GenerateGUID();
            Console.WriteLine("GUID: {0}", newGUID);

            string[] dateList = curentDate.Split('-');
            string[] BIDList = newGUID.Split('-');

            string strBID = BIDList[0] + dateList[0]
                          + BIDList[1] + dateList[1]
                          + BIDList[2] + dateList[2]
                          + BIDList[3] + dateList[3] 
                          + BIDList[4];

            return strBID;
        }

        public static string GetEncryptedBID()
        {
            string newBID = GenerateBID(); // Generate bid
            Console.WriteLine("BID: {0}", newBID);
            string encryptedBID = AESTest.Encrypt(newBID); // Encrypt bid.
            Console.WriteLine("Encrypted BID: {0}", encryptedBID);
            return encryptedBID;
        }
    }
}
