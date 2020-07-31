import base64
import os

def base64ImagePath(root_path):
    path_content = os.walk(root_path)
    image_base64 = open(root_path+"\\image_base64.md", "w")
    for root, dirs, files in path_content:
        for image in files: 
            suffix = image.split(".")[-1]
            if suffix not in ["png","jpg"]:
                continue
            image_path = os.path.join(root,image)
            with open(image_path, "rb") as imageFile:
                b_str = base64.b64encode(imageFile.read())
                text = b_str.decode('utf-8')
                # print(text)
                image_base64.write("Image Path:`"+image_path+"`\n")
                image_base64.write("```html\n")
                html_text = "data:image/"+suffix+";base64,"+text+"\n"
                image_base64.write(html_text)
                image_base64.write("```\n\n")
    image_base64.close()
 

if __name__ == '__main__':
    # base64ImagePath(root_path = r"E:\chromium-web\resources\logo")
    base64ImagePath(root_path = r"E:\chromium-web\resources\news")