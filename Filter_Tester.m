close;
clear;

input = imread("Noisy_dataset/noise2.png");
Inoise = im2double(input);
I_hsv = rgb2hsv(input);

hueval = 10*mean(mean(I_hsv(:,:,1))); 
scaleval = 10*mean(mean(I_hsv(:,:,2)));
valval = 10*mean(mean(I_hsv(:,:,3))); % extracting hsv features of the image for it to act as a unique image signature

fprintf("Hue : %d | Scale : %d | Value : %d",hueval,scaleval,valval);

output_avg = Avgfilter(Inoise,5,3);
output_med = Medianfilter(Inoise,3,3,5);
output_gaus = Gaussianfilter(Inoise,0.7);

figure;
subplot(2,2,1)
imshow(Inoise);
title("Speckled Image");
subplot(2,2,2);
imshow(output_avg);
title("Avg Filter");
subplot(2,2,3);
imshow(output_med);
title("Med Filter");
subplot(2,2,4);
imshow(output_gaus);
title("Gaussian Filter");

function Avg_output = Avgfilter(img,kernel_h,kernel_w)

    Avg_in = fspecial('average',[kernel_h,kernel_w]);
    Avg_output = imfilter(img,Avg_in);
    
end

function med_output = Medianfilter(img,sizex,sizey,sizez)

    med_output = medfilt3(img,[sizex,sizey,sizez]);
end

function gaus_output = Gaussianfilter(img,sigma)

    gaus_output = imgaussfilt3(img,sigma);
end




