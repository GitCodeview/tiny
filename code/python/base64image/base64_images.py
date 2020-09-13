import base64
 

if __name__ == '__main__':
    with open(r"E:\github\tiny\scripts\base64image\images\square4-51.png", "rb") as imageFile:
        b_str = base64.b64encode(imageFile.read())
        text = b_str.decode('utf-8')
        print(text)

        fh = open("out-byteImage", "wb")
        fh.write(b_str)
        fh.close()

        fh = open("out-textImage", "w")
        fh.write(text)
        fh.close()

        fh = open("out-byteToSave.png", "wb")
        fh.write(base64.b64decode(b_str))
        fh.close()

        fh = open("out-textToSave.png", "wb")
        fh.write(base64.b64decode(text))
        fh.close()

        fh = open("out-byteToSave.jpg", "wb")
        fh.write(base64.b64decode(b_str))
        fh.close()

        fh = open("out-textToSave.jpg", "wb")
        fh.write(base64.b64decode(text))
        fh.close()