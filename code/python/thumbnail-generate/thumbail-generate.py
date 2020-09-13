from PIL import Image
import os
imagePath = '/home/ti/gitlab/tiny-coding/python/thumbnail-generate/read.png'
size = 256

try:
    imageName = os.path.basename(imagePath)
    newImage = Image.open(imagePath)
    (height, width) = newImage.size
    ratio = min(height, width)/size
    thumbnail_size = (height/ratio, width/ratio)
    newImage.thumbnail(thumbnail_size)
    (height, width) = newImage.size
    (height_offset, width_offset) = ((height-size)/2, (width-size)/2)
    squareImage = newImage.crop((height_offset, width_offset, height-height_offset, width-width_offset))
    newImage.save("thumbnail.png")
    squareImage.save("square.png")
    ## TODO: add cycle crop
    # newImage.save("thumbnail_%s_%s" % (imageName, "_".join(size)))
except Exception as e: 
    print(e) 