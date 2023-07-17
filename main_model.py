import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, roc_auc_score, mean_squared_error, mean_absolute_error, r2_score, log_loss
from sklearn.metrics import mean_squared_error as mse
from sklearn.metrics import confusion_matrix, roc_curve, precision_recall_curve
from sklearn.calibration import calibration_curve
from sklearn.model_selection import learning_curve
import matplotlib.pyplot as plt

#
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.naive_bayes import GaussianNB
from sklearn.naive_bayes import MultinomialNB
from sklearn.naive_bayes import BernoulliNB
from sklearn.ensemble import AdaBoostClassifier


dataframe = pd.read_csv("C:/Users/Rohan Mahesh Rao/Desktop/Dip/Image-Despeckling/spreadsheets/Dataset_new.csv")
dataframe.head()




dataframe = dataframe.sample(frac = 1) # to shuffle the dataset 
y = dataframe['Kernel_width']
feature_names = ['Hue','Sat','Val']
x = dataframe[feature_names]
x.head()




x = np.asarray(x).astype('float32')
x_train, x_test, y_train, y_test = train_test_split(x,y, test_size=0.01, shuffle=True)






model1 = LogisticRegression()
model2 = DecisionTreeClassifier()
model3 = RandomForestClassifier()
model4 = SVC()
model5 = GaussianNB()
model6 = MultinomialNB()
model7 = BernoulliNB()
model8 = AdaBoostClassifier()


#training
model1.fit(x_train, y_train)
pred1 = model1.predict(x_test)
model2.fit(x_train, y_train)
pred2 = model2.predict(x_test)
model3.fit(x_train, y_train)
pred3 = model3.predict(x_test)
model4.fit(x_train, y_train)
pred4 = model4.predict(x_test)
model5.fit(x_train, y_train)
pred5 = model5.predict(x_test)
model6.fit(x_train, y_train)
pred6 = model6.predict(x_test)
model7.fit(x_train, y_train)
pred7 = model7.predict(x_test)
model8.fit(x_train, y_train)
pred8 = model8.predict(x_test)

def get_kernel1(x_given):
    return model1.predict(x_given)
def get_kernel2(x_given):
    return model2.predict(x_given)
def get_kernel3(x_given):
    return model3.predict(x_given)
def get_kernel4(x_given):
    return model4.predict(x_given)
def get_kernel5(x_given):
    return model5.predict(x_given)
def get_kernel6(x_given):
    return model6.predict(x_given)
def get_kernel7(x_given):
    return model7.predict(x_given)
def get_kernel8(x_given):
    return model8.predict(x_given)




hsv_inputs = open("C:/Users/Kavita/Desktop/Image_Despeckling/Image-Despeckling/hsv_inputs.txt","r")
x_inp = str(hsv_inputs.read())
x_given = []

for i in range (0,3):
    x_given.append(int(x_inp[i]))

print(x_given)

pre1 = get_kernel1([x_given])
print("Predicted kernel size for 1 :",round(pre1[0]))
pre2 = get_kernel2([x_given])
print("Predicted kernel size for 2 :",round(pre2[0]))
pre3 = get_kernel3([x_given])
print("Predicted kernel size for 3 :",round(pre3[0]))
pre4 = get_kernel4([x_given])
print("Predicted kernel size for 4 :",round(pre4[0]))
pre5 = get_kernel5([x_given])
print("Predicted kernel size for 5 :",round(pre5[0]))
pre6 = get_kernel6([x_given])
print("Predicted kernel size for 6 :",round(pre6[0]))
pre7 = get_kernel7([x_given])
print("Predicted kernel size for 7 :",round(pre7[0]))
pre8 = get_kernel8([x_given])
print("Predicted kernel size for 8 :",round(pre8[0]))



preds = [pred1, pred2, pred3, pred4, pred5, pred6, pred7, pred8]
mses = []

for pred in preds:
    mse = mean_squared_error(y_test, pred)
    mses.append(mse)

print(mses)

# Calculating RootMeanSquaredError

rmses = []

for mse in mses:
    rms = np.sqrt(mse)
    rmses.append(rms)

print(rmses)

# Calculating MeanAbsoluteError

maes = []

for pred in preds:
    mae = mean_absolute_error(y_test, pred)
    maes.append(mae)

print(maes)


#Calculating R2Score

r2s = []

for pred in preds:
    r2 = r2_score(y_test, pred)
    r2s.append(r2)

print(r2s)


# Data Visualisation

def plot_learning_curves(classifier, x, y):
    plt.figure(figsize=(3,3))
    train_sizes, train_scores, valid_scores = learning_curve(classifier, x, y, cv=5, scoring='neg_mean_squared_error')
    train_mean = -np.mean(train_scores, axis=1)
    train_std = np.std(train_scores, axis=1)
    valid_mean = -np.mean(valid_scores, axis=1)
    valid_std = np.std(valid_scores, axis=1)
    plt.plot(train_sizes, train_mean, label='Training Error')
    plt.plot(train_sizes, valid_mean, label='Validation Error')
    plt.fill_between(train_sizes, train_mean - train_std, train_mean + train_std, alpha=0.1)
    plt.fill_between(train_sizes, valid_mean - valid_std, valid_mean + valid_std, alpha=0.1)
    plt.title('Learning Curves')
    plt.xlabel('Training Set Size')
    plt.ylabel('Error')
    plt.legend()
    plt.show()

classifiers = [LogisticRegression(), DecisionTreeClassifier(), RandomForestClassifier(), SVC(), GaussianNB(), MultinomialNB(), BernoulliNB(), AdaBoostClassifier()]

for classifier in classifiers:
    plot_learning_curves(classifier, x, y)


