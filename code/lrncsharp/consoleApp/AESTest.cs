using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Security.Cryptography;

using System.Text.Json;
using Newtonsoft.Json;


namespace consoleApp
{
    class AESTest
    {
        private static string _base64_key = "Wl7yV2/uqfwbuDLDUEQCIskld11RnGx50Npp2kTddAY=";
        private static string _base64_IV = "BGsKg5I1oEmsOik7Gl9Qxw==";

        public AESTest(string key, string IV){
            _base64_key = key;
            _base64_IV = IV;
        }

        public static void MainTest()
        {
            //string original = "Here is some data to encrypt!";
            string newBID = GUIDTest.GenerateBID(); // Generate bid
            Console.WriteLine("BID: {0}", newBID);
            string encryptedBID = Encrypt(newBID); // Encrypt bid.
            Console.WriteLine("Encrypted BID: {0}", encryptedBID);
            // var url = "http://120.24.168.112:31001/web/acceleration/findAccelerationInfo";
            var url = "http://120.24.168.112:31001/web/acceleration/findWhiteList";
            var responseJsonText = HttpClient.DownloadStringWithBid(url, encryptedBID);
            JSONTest JsonObj = new JSONTest(responseJsonText);
            JsonElement root = JsonObj.GetRoot();
            JsonElement bodyMessageElement = root.GetProperty("bodyMessage");
            string base64encrypted = bodyMessageElement.GetString();
            // Create a new instance of the Aes
            // class.  This generates a new key and initialization
            // vector (IV).
            using (Aes myAes = Aes.Create())
            {
                myAes.Key = Convert.FromBase64String(_base64_key);
                myAes.IV = Convert.FromBase64String(_base64_IV);
                // Encrypt the string to an array of bytes.
                //byte[] encrypted = EncryptStringToBytes_Aes(original, myAes.Key, myAes.IV);

                //string base64encrypted = Convert.ToBase64String(encrypted);
                byte[] encrypted_bytes = Convert.FromBase64String(base64encrypted);
                FileTest.Write("encrypted_bytes", encrypted_bytes);
                // Decrypt the bytes to a string.
                string roundtrip = DecryptStringFromBytes_Aes(encrypted_bytes, myAes.Key, myAes.IV);
                FileTest.Write("roudntrip.txt", roundtrip);

                byte[] read_bytes = FileTest.Read("encrypted_bytes");
                string read_base64_text = Convert.ToBase64String(read_bytes);

                string roundtrip_text = Encoding.UTF8.GetString(FileTest.Read("roudntrip.txt"));

                List<String> whiteList = JsonConvert.DeserializeObject<List<string>>(roundtrip_text);
                for (int i = 1; i < whiteList.Count; i++)
                {
                    whiteList[i] = whiteList[i].Insert(0,"||");
                }
                string wListRule = JsonConvert.SerializeObject(whiteList, Formatting.Indented);
                //Display the original data and the decrypted data.
                //Console.WriteLine("Original:   {0}", original);
                Console.WriteLine("key: {0} \nIV: {1}", Convert.ToBase64String(myAes.Key), Convert.ToBase64String(myAes.IV));
                Console.WriteLine("Base64 encrypted:\n{0}", base64encrypted);
                Console.WriteLine("read_base64_text:\n{0}", read_base64_text);
                Console.WriteLine("Round Trip:\n{0}", roundtrip);
                Console.WriteLine("roundtrip_text:\n{0}", roundtrip_text);

                Console.WriteLine("White List Rules:\n{0}", wListRule);
            }
        }

        public static string Encrypt(string plainText)
        {

            return EncryptStringToBase64String_Aes(plainText, 
                    Convert.FromBase64String(_base64_key),
                    Convert.FromBase64String(_base64_IV));
        }

        public static string EncryptStringToBase64String_Aes(string plainText, byte[] Key, byte[] IV)
        {

            return Convert.ToBase64String(
                            EncryptStringToBytes_Aes(plainText,Key, IV));
        }

        public static byte[] EncryptStringToBytes_Aes(string plainText, byte[] Key, byte[] IV)
        {
            // Check arguments.
            if (plainText == null || plainText.Length <= 0)
                throw new ArgumentNullException("plainText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("IV");
            byte[] encrypted;

            // Create an Aes object
            // with the specified key and IV.
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                // Create an encryptor to perform the stream transform.
                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

                // Create the streams used for encryption.
                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {
                            //Write all data to the stream.
                            swEncrypt.Write(plainText);
                        }
                        encrypted = msEncrypt.ToArray();
                    }
                }
            }

            // Return the encrypted bytes from the memory stream.
            return encrypted;
        }

        public static string Decrypt(string cipherBase64Text)
        {
            return DecryptStringFromBas64String_Aes(
                    cipherBase64Text,
                    Convert.FromBase64String(_base64_key),
                    Convert.FromBase64String(_base64_IV));
        }

        public static string DecryptStringFromBas64String_Aes(string cipherBase64Text, byte[] Key, byte[] IV)
        {
            return DecryptStringFromBytes_Aes(
                        Convert.FromBase64String(cipherBase64Text),
                        Key, IV);
        }

        public static string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
        {
            // Check arguments.
            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("IV");

            // Declare the string used to hold
            // the decrypted text.
            string plaintext = null;

            // Create an Aes object
            // with the specified key and IV.
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                // Create a decryptor to perform the stream transform.
                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

                // Create the streams used for decryption.
                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {

                            // Read the decrypted bytes from the decrypting stream
                            // and place them in a string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }

            return plaintext;
        }
    }
}
