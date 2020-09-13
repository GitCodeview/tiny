#include <string>
#include <iostream>

using namespace std;

void setString(string& string_text)
{
    char* char_text = new char[126];
    char_text[0]='t';
    string_text = char_text;
    // string_text.insert(0,char_text);
    delete char_text[];
}

int main(){
    string string_text= '';
    cout << string_text << endl;
    setString(string_text);
    cout << string_text << endl;
    return 0;
}