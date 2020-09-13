import base64
def pic2text():
  f=open('level.jpg','rb') #二进制方式打开图文件
  ls_f=base64.b64encode(f.read()).decode() #读取文件内容，转换为base64编码
  f.close()
  print(ls_f)

  ftext= open('level.txt', 'w')
  ftext.write(str(ls_f))
  ftext.close()


def text2pic():
  ftext= open('level.txt', 'r')
  bs = ftext.read()
  print(len(bs))
  ftext.close()
  imgdata=base64.b64decode(bs)
  file=open('test.jpg','wb')
  file.write(imgdata)
  file.close()

pic2text()
text2pic()

