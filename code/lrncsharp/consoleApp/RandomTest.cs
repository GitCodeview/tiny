using System;
using System.Collections.Generic;
using System.Text;

namespace consoleApp
{
    class RandomTest
    {
        Random _random;

        public RandomTest( )
        {
            _random = new Random();
        }

        public int GetRandomIndex()
        {
            int index;
            index = _random.Next();
            return (index % 4);
        }

        public void DisplayRandomIndexs()
        {
            int displayCnt = 10;
            List<int> indexList = new List<int>();
            for (int i = 0; i < displayCnt; i++)
            {
                indexList.Add(GetRandomIndex());
            }
            Console.Write("Ten random indexs: ");
            indexList.ForEach(i => Console.Write("{0} ", i));
            Console.WriteLine("\n");
        }
    }
}
