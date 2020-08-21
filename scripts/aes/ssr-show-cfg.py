import json
import os
from base64 import b64encode
from base64 import b64decode
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from Crypto.Util.Padding import unpad


def DecryptBinaryFile(file_path, key, iv):
    if not os.access(file_path, os.R_OK):
        print("\n无可读文件：", file_path)
        return "[]"
    with open(file_path, "rb") as binary_file:
        bid_bytes = binary_file.read()
        cipher = AES.new(key, AES.MODE_CBC, iv)
        pt = unpad(cipher.decrypt(bid_bytes), AES.block_size)
        origin_text = str(pt, encoding = "utf-8")
        return origin_text

if __name__ == '__main__':
    
    key_set = "Wl7yV2/uqfwbuDLDUEQCIskld11RnGx50Npp2kTddAY="
    iv_set = "BGsKg5I1oEmsOik7Gl9Qxw=="

    key = b64decode(key_set)
    iv = b64decode(iv_set)

    printText_dict = {'server_list':{}, 
                      'white_list':{}
                     }

    serverList = DecryptBinaryFile(".sl", key, iv)
    serverListJson = json.loads(serverList)
    printText_dict['server_list'] = serverListJson
    print("\n\n==================== serverList Start=======================")
    for server in serverListJson:
        print("\n  server: ", server['server'])
        print("  server_port: ", server['server_port'])
        print("  password: ", server['password'])
        print("  method: ", server['method'])
    print("==================== serverList End =======================")

    whiteList = DecryptBinaryFile(".wl", key, iv)
    whiteListJson = json.loads(whiteList)
    printText_dict['white_list'] = whiteListJson
    print("\n\n==================== whiteList Start=======================")
    whiteListSize = 0
    for website in whiteListJson:
        whiteListSize = whiteListSize + 1
        print("  ", website)
    print(whiteListSize)
    print("==================== whiteList End =======================")

    os.system("pause")