
#https://keras.io/getting_started/intro_to_keras_for_engineers/
#https://comparisons.financesonline.com/tensorflow-vs-opencv
import numpy as np #used for mathematical function
import pandas as pd #used for  data structures, database operation, numerical tables and time series
import sklearn as sk #used for machine learning specially classification, regression, clustering algorithms and dimensionality reduction
import cv2 #Huge suite of Computer Vision algorithms (2500), mostly non-neural network based
import tensorflow as tf #AL, ML and Deep Neural Network, #Computer Vision via Deep Learning, #
import keras #acts as an interface for the TensorFlow library
#from keras.preprocessing.image import load_img
from tensorflow import keras
from tensorflow.keras import layers
import matplotlib as mpl #used for data visualization
import matplotlib.pyplot as plt #used for ploting
import seaborn as sns #used for  statistical graphics
import PIL as img #python imaging library #https://pillow.readthedocs.io/en/stable/

# Commented out IPython magic to ensure Python compatibility.
import seaborn as sns
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn import metrics
from sklearn.metrics import confusion_matrix, classification_report, f1_score
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.datasets import make_classification
# %matplotlib inline
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import mean_squared_error
from math import sqrt

from sklearn.neighbors import NearestNeighbors
from sklearn.impute import KNNImputer
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans, DBSCAN, AgglomerativeClustering
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.metrics import davies_bouldin_score, silhouette_score, calinski_harabasz_score
from yellowbrick.cluster import KElbowVisualizer, SilhouetteVisualizer
from yellowbrick.style import set_palette
from yellowbrick.contrib.wrapper import wrap

from google.colab import drive
drive.mount('/content/drive') #mount
#drive.flush_and_unmount() #unmount

# --- Importing Dataset ---
X = pd.read_csv('/content/drive/MyDrive/Tawshif/covid_img_13.csv') #3x3 median filtered image

X

n_clusters = range(1,41)
SSE=[] #sum-of-squared errors (SSE)
for i in n_clusters:
    kmean= KMeans(i) #Instantiate the KMeans class for each class from 1 to 14
    kmean.fit(X) #Learn and estimate the parameters of the transformation
    SSE.append(kmean.inertia_)  #returns the SSE value

plt.figure(figsize=(8,5))
plt.plot(n_clusters, SSE, 'bd-')
plt.xlabel('Number of Clusters')
plt.ylabel('Within Cluster Sum of Squares (WCSS)')
plt.title('The Elbow Method showing the optimal K')
plt.show()

