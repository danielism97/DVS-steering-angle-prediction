# Packages ---------------------------------------------------------------------------------
import numpy as np
import pandas as pd
from scipy import ndimage
from PIL import Image
from sklearn.model_selection import train_test_split

# Loading all data -------------------------------------------------------------------------
for i in range(400):
    image = np.array(ndimage.imread('Data_trial/'+str(i)+'_scaled.jpg', flatten=False))
    image_flat = image.reshape(image.shape[0]*image.shape[1]*image.shape[2],1)
    if(i == 0):
        X = np.zeros((image.shape[0]*image.shape[1]*image.shape[2],400))
    X[:,i] = image_flat[:,0] # data matrix x.shape = (230400,400)

X = X/255.

yvals = pd.read_excel( 'Data_trial/data_trial.xlsx',sheet_name = 'Sheet1',nrows = 400)
y = yvals.values[:,1].reshape(yvals.values[:,1].shape[0],1).T # y.shape = (1,400)
X_train, X_test, y_train, y_test = train_test_split(X.T, y.T, test_size = 0.25)
X_dev, X_test, y_dev, y_test = train_test_split(X_test, y_test, test_size = 0.5)
# training set
X_train = X_train.T # X_train.shape = (230400, 300)
y_train = y_train.T # y_train.shape = (1, 300)
# development set
X_dev = X_dev.T     # X_Dev.shape = (230400, 50)
y_dev = y_dev.T     # y_dev.shape = (1, 50)
# test set
X_test = X_test.T   # X_test.shape = (230400, 50)
y_test = y_test.T   # y_test.shape = (1, 50)

print(X_train.shape)
print(X_dev.shape)
