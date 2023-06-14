# ML Assisted Despeckling of Images (DIP (UE20EC317))
Predicting the appropriate kernel size(Lee filter) for a given speckled SAR image based on it's HSV values, using decision tree regression.

Post-processing using unsharp masking has also been implemented. 

SAR images: https://www.kaggle.com/code/samvram/flood-detection-sar/data

Speckling Noise - 

Speckling noise is a common type of noise that affects digital images. It is characterized by the appearance of grain-like or salt-and-pepper patterns, where bright and dark pixels are randomly scattered throughout the image.

Speckling noise occurs due to various factors, including the imaging sensor's inherent noise, imperfect transmission or storage of data, or interference during image acquisition. This noise is particularly prominent in images acquired using ultrasound, synthetic aperture radar (SAR), or laser-based imaging systems.

The speckling noise can degrade the quality and clarity of an image, making it difficult to extract accurate information or perform subsequent image analysis tasks. It can obscure fine details, reduce contrast, and introduce unwanted artifacts.

Several techniques are used to mitigate speckling noise. One common approach is to employ image filtering methods that aim to preserve image details while reducing noise. These techniques can be categorized into linear and non-linear filtering methods, each with its advantages and limitations. Linear filters, such as mean or median filters, are effective in reducing speckling but can also blur the image. Non-linear filters, such as the Lee or Frost filters, are designed to preserve edges and fine details while effectively suppressing speckle noise.

Solutions using Lee filters have been explored here
