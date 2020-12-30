
import json
from base64 import b64encode
from base64 import b64decode
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from Crypto.Util.Padding import unpad
from Crypto.Random import get_random_bytes

def init():
    key_128bit = b64encode(get_random_bytes(16)).decode('utf-8')
    key_192bit = b64encode(get_random_bytes(24)).decode('utf-8')
    key_256bit = b64encode(get_random_bytes(32)).decode('utf-8')
    with open("aes.info", "wb") as aes_info_file:
        code_json = json.dumps({'key_128bit':key_128bit, 'key_192bit':key_192bit, 'key_256bit':key_256bit})
        aes_info_file.write(str.encode(code_json))
        aes_info_file.close()
        print("Generate random code success.")

def getTextData(data_file_path):
    with open(data_file_path, "r", encoding='utf-8') as data_file:
        text_data = data_file.read()
        print("The original text is: ")
        print("----------------------------------------------------------------")
        print(text_data)
        print("---------------------------------------------------------------- \n")
        data_file.close()
        return text_data

def getKeyIv():
    with open("aes.info", "rb") as aes_info_file:
        json_input = bytes.decode(aes_info_file.read())
        b64_aes_info = json.loads(json_input)
        key = b64decode(b64_aes_info['key_256bit'])
        iv = b64decode(b64_aes_info['key_128bit'])
        # key = b64_aes_info['key_256bit']
        # iv = b64_aes_info['key_128bit']
    return [key, iv]

def aes_cbc_encrypt(test_data, key, iv):
    # key = b64decode("hSxeHK4LDIXfetaI9+L9qA==")
    cipher = AES.new(key, AES.MODE_CBC, iv)
    data = str.encode(test_data)
    ct_bytes = cipher.encrypt(pad(data, AES.block_size))
    key_set = b64encode(key).decode('utf-8')
    iv_set = b64encode(iv).decode('utf-8')
    ct = b64encode(ct_bytes).decode('utf-8')
    result = json.dumps({'key':key_set, 'iv':iv_set, 'ciphertext':ct})
    print("The encrypted text is: ")
    print("----------------------------------------------------------------")
    print(ct)
    print("---------------------------------------------------------------- \n")
    with open("result.aes.cbc", "wb") as aes_result_file:
        aes_result_file.write(str.encode(result))
        aes_result_file.close()
 
def aes_cbc_decrypt():
    with open("result.aes.cbc", "rb") as aes_result_file:
        json_input = bytes.decode(aes_result_file.read())
        b64 = json.loads(json_input)
        key = b64decode(b64['key'])
        iv = b64decode(b64['iv'])
        ct = b64decode(b64['ciphertext'])
        cipher = AES.new(key, AES.MODE_CBC, iv)
        pt = unpad(cipher.decrypt(ct), AES.block_size)
        origin_text = str(pt, encoding = "utf-8")  
        print("The original text is: ")
        print("----------------------------------------------------------------")
        print( origin_text)
        print("---------------------------------------------------------------- \n")
 
if __name__ == '__main__':
    init()
    text_data = getTextData("text.dat")
    # key_set = bytes("578B11BBE7A760548FF64225BC7D3A85", encoding = "utf-8")
    # iv_set = bytes("109E711228DD3B14", encoding = "utf-8")
    [key_set, iv_set] = getKeyIv()
    aes_cbc_encrypt(text_data, key_set, iv_set)  # 加密
    aes_cbc_decrypt()  # 解密