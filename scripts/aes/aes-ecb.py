# 简析1：这里采用了面向对象的写法，创建了一个类，同时也偷懒直接把密钥写死成了类的属性。
#        如果有灵活修改密钥的需求，将密钥作为参数传进去即可。 
# 简析2：例子里用了ECB模式，这是AES加密最简单也是很常用的模式。另外一个常用模式是CBC，
#       会比ECB模式多一个初始偏移向量iv：cipher = AES.new(self.__key, AES.MODE_CBC, iv)。 
# 简析3：pad和unpad分别是填充函数和逆填充函数。因为AES加密对加密文本有长度要求，必须是密钥字节数的倍数。
#       这里的encryptKey在经过base64解码后的长度是16个字节。

from Crypto.Cipher import AES
import base64
  
class AEScoder:
  def __init__(self):
    self.__encryptKey = "iEpSxImA0vpMUAabsjJWug=="
    self.__key = base64.b64decode(self.__encryptKey)
  # AES加密
  def encrypt(self,data):
    BS = 16
    pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
    cipher = AES.new(self.__key, AES.MODE_ECB)
    encrData = cipher.encrypt(pad(data))
    #encrData = base64.b64encode(encrData)
    return encrData
  # AES解密
  def decrypt(self,encrData):
    #encrData = base64.b64decode(encrData)
    #unpad = lambda s: s[0:-s[len(s)-1]]
    unpad = lambda s: s[0:-s[-1]]
    cipher = AES.new(self.__key, AES.MODE_ECB)
    decrData = unpad(cipher.decrypt(encrData))
    return decrData.decode('utf-8')

if __name__ == '__main__':
  with open("text.data", "r") as data_file:
    aes_coder = AEScoder()
    text_data = data_file.read()
    e_data = aes_coder.encrypt(text_data)  # 加密
    d_data = aes_coder.decrypt(e)  # 解密
    print("加密:", e_data)
    print("解密:", d_data)