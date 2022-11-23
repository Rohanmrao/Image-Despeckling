input = imread("Noisy_dataset/noise66.png");
Inoise = im2double(input);
imshow(Inoise);
title("Speckled Image");

output_avg = Avgfilter(Inoise,3,3);
output_med = Medianfilter(Inoise,3,3,5);
output_gaus = Gaussianfilter(Inoise,0.5);
figure;
subplot(1,1,1);
imshow(output_avg);
title("Avg Filter");
figure;
subplot(1,1,1);
imshow(output_med);
title("Med Filter");
figure;
subplot(1,1,1);
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




