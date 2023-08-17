#!/usr/bin/env/ python3

import pandas as pd
import numpy as np 
import tensorflow as tf
from keras.models import Sequential
import cv2
import os
from imgarray_clean import clean_matrix
from imgarray_noisy import noise_matrix

class deepnet_class():

    def __init__(self):

        self.speckled_images_path = "/home/rohan/Desktop/dip/Image-Despeckling/New_images/noisy/"
        self.clean_images_path = "/home/rohan/Desktop/dip/Image-Despeckling/New_images/clean_rename/"
        self.speckled_images = []
        self.clean_images = []


    def clean_images_arr(self):

        self.clean_images = clean_matrix.get_array_clean(self.clean_images,self.clean_images_path)

        return self.clean_images

    def noisy_images_arr(self):

        self.speckled_images = noise_matrix.get_array_noisy(self.speckled_images, self.speckled_images_path)

        return self.speckled_images
    
if __name__ == '__main__':

    class_obj = deepnet_class()

  
    clean_arr = class_obj.clean_images_arr()
    print("Clean\n",clean_arr)

    print("\n***\n")
    
    speck_arr = class_obj.noisy_images_arr()
    print("Noisy\n",speck_arr)

    
    

