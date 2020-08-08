using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace consoleApp
{
    class JSONTest
    {
        private JsonDocument _docJson;

        public JSONTest(string jsonText)
        {
            _docJson = JsonDocument.Parse(jsonText);
        }

        public JsonElement GetRoot()
        {
            return _docJson.RootElement;
        }
    }
}
