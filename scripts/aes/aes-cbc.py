
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
    with open("aes.info", "w") as aes_info_file:
        code_json = json.dumps({'key_128bit':key_128bit, 'key_192bit':key_192bit, 'key_256bit':key_256bit})
        aes_info_file.write(code_json)
        aes_info_file.close()
        print("Generate random code success.")

def aes_cbc_encrypt(test_data):
    key = b64decode("hSxeHK4LDIXfetaI9+L9qA==")
    cipher = AES.new(key, AES.MODE_CBC)
    data = str.encode(test_data)
    ct_bytes = cipher.encrypt(pad(data, AES.block_size))
    iv = b64encode(cipher.iv).decode('utf-8')
    ct = b64encode(ct_bytes).decode('utf-8')
    result = json.dumps({'iv':iv, 'ciphertext':ct})
    print("The original text is: ")
    print("----------------------------------------------------------------")
    print( origin_text)
    print("---------------------------------------------------------------- \n")
    with open("result.aes.cbc", "wb") as aes_result_file:
        aes_result_file.write(str.encode(result))
        aes_result_file.close()
 
def aes_cbc_decrypt():
    with open("result.aes.cbc", "rb") as aes_result_file:
        json_input = bytes.decode(aes_result_file.read())
        b64 = json.loads(json_input)
        key = b64decode("hSxeHK4LDIXfetaI9+L9qA==")
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
    with open("text.dat", "r", encoding='utf-8') as data_file:
        text_data = data_file.read()
        print("The original text is: ")
        print("----------------------------------------------------------------")
        print(text_data)
        print("---------------------------------------------------------------- \n")
        data_file.close()
        aes_cbc_encrypt(text_data)  # 加密
        aes_cbc_decrypt()  # 解密