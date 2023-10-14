# RDTLM

RDTLM: Robust Deep Transfer Learning Model for Automated Diagnosis of COVID-19 Utilizing Chest X-Ray Images

# Table of Content
*	[Getting Started](#getting-started)
*	[Datasets](#datasets)
*	[Prerequisites](#prerequisites)
*	[Download and install code](#download-and-install-code)
*	[Authors](#authors)
*	[References](#references)

# Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Datasets
The dataset can be found in the COVID-19 Radiography Database directory. The dataset is collected from [1].

To download the dataset directly from Kaggle, visit: https://www.kaggle.com/datasets/tawsifurrahman/covid19-radiography-database

### Prerequisites

We have tested RDTLM on MATLAB 2020a and Python on the Windows 10 operating system. You would need to install the following software before replicating this framework in your local or server machine. 

1. MATLAB 2020a or newer version

    To download the MATLAB software, visit: https://www.mathworks.com/products/matlab.html
   
2. Deep Learning Toolbox

   To download the Deep Learning Toolbox, visit: https://www.mathworks.com/products/deep-learning.html

3. Python version 3.11.6 or newer
   
    To download the Python, visit: https://www.python.org/downloads/ 
    

## Download and install code

- Retrieve the code

```
git clone https://github.com/habib-tamuk/RDTLM.git

```

- To run the program, first install all required software and toolbox. Then do the following instructions:
    - Download the COVID-19 Radiography Database.
    - Rename the **Normal** folder as **Healthy** and **Viral Pneumonia** folder as **Pneumonia**.
    - To measure the enhancement performance run the **Preprocessing.m** program in MATLAB.
    - To measure the enhancement performance run the **Preprocessing_w_kmeans_C.m** program in MATLAB.
    - To select the value of K for K-means clustering run **Elbow Method for K selection.py** in Python.
    - Now, run the **Data_Set_Preparation.m** program in MATLAB for dataset preparation.
    - To extract the features(DarkNet-19), select the features(mRMR) and classify(SVM) the patients, run **Darknet19.m** in MATLAB.

## Authors

Md Habibur Rahman, Farhana Islam, Md Selim Hossain, Avdesh Mishra, Salem A. Alyami, Mohammad Ali Moni. 

For any issue please contact Md Habibur Rahman, habibur0001@bdu.ac.bd 

## References

1. Rahman, T., Khandakar, A., Qiblawey, Y., Tahir, A., Kiranyaz, S., Kashem, S.B.A., Islam, M.T., Al Maadeed, S., Zughaier, S.M., Khan, M.S., and Chowdhury, M.E. Exploring the effect of image enhancement techniques on COVID-19 detection using chest X-ray images. Computers in biology and medicine, 2021, 132, 104319.
