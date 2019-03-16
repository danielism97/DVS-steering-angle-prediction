from PIL import Image
import os

os.chdir('Data_trial')
for i in range(400):
     image = Image.open(str(i)+'.jpg')
     image = image.resize((160,120),Image.ANTIALIAS)
     image.save(str(i)+'_scaled.jpg')
