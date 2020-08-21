
# Advanced Encryption Standard (AES)

![aes](aes.jpg)

[Advanced Encryption Standard - Wikipedia](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)

The Advanced Encryption Standard (AES), also known by its original name Rijndael (Dutch pronunciation: [ˈrɛindaːl]), is a specification for the encryption of electronic data established by the U.S. National Institute of Standards and Technology (NIST) in 2001.

AES is a subset of the Rijndael block cipher[3] developed by two Belgian cryptographers, Vincent Rijmen and Joan Daemen, who submitted a proposal to NIST during the AES selection process.[6] Rijndael is a family of ciphers with different key and block sizes. For AES, NIST selected three members of the Rijndael family, each with a block size of 128 bits, but three different key lengths: 128, 192 and 256 bits.

## Content

[AES 介绍](aes-intro.md)


## Others
- 打包 Python 脚本为 exe 程序的命令, [Pyinstaller Manual](https://pyinstaller.readthedocs.io/en/stable/usage.html)：
  ```sh
  ## 安装 pyinstaller
  pip install pyinstaller
  ## --onefile 打包成单独的一个 exe 文件
  pyinstaller --onefile ./aes.py 
  ```
