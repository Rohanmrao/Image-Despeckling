noise_img = imread("C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Testset\speckled\speckled3.png");
clean_img = imread("C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Testset\cleaned\cleaned3.png");

a = rgb2gray(clean_img);
b = rgb2gray(noise_img);

% input = imread("E:\5th SEM\DIP-1\project\SAR-Image-Despeckling-main\SAR-Image-Despeckling-main\Noisy_Dataset/noise4.png");
% Inoise = im2double(input);
output_avg = Avgfilter(b,7,7);
output_med = Medianfilter(b,3,3,3);
output_gaus = Gaussianfilter(b,1.5);
figure;
subplot(2,2,1)
imhist(clean_img);
title("Despeckled Image");
subplot(2,2,2);
imhist(output_avg);
title("Avg Filter");
subplot(2,2,3);
imhist(output_med);
title("Med Filter");
subplot(2,2,4);
imhist(output_gaus);
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

% imhist(output_avg);title('avg filter');
% imhist(output_med);title('med filter');
% imhist(output_gaus);title('gauss filter');

