using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace consoleApp
{
    class FileTest
    {
        public static void Write(string path, string text)
        {
            File.WriteAllText(path, text);
        }

        public static void Write(string path, byte[] bytes)
        {
            File.WriteAllBytes(path, bytes);
        }

        public static byte[] Read(string path)
        {
            return File.ReadAllBytes(path);
        }
    }
}
