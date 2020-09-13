if __name__ == '__main__':
    with open(r"E:\chromium-web\resources\logo\logo_default_60x60.png", "rb") as imageFile:
        byte_png = imageFile.read()
        with open(r"E:\chromium-web\resources\logo\logo_default_60x60.dat","wb") as textfile:
            textfile.write(byte_png)
            textfile.close()
        imageFile.close()