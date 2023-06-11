% comparison of images for the dip project

% load image paths, load noiser code, get noisy image, get lee filter
% output, get avg filter output, median filter output, compare histograms 

clc;
clear;
close all;

clean_img = "C:\Users\Rohan Mahesh Rao\Desktop\HIST\test.png";
noisy_img = "C:\Users\Rohan Mahesh Rao\Desktop\HIST\speckled.png";
noisy_storage = "C:\Users\Rohan Mahesh Rao\Desktop\HIST\";

input = imread(clean_img);
noised = imread(noisy_img);

% random_parameter = 0.01 + rand*(1.0 - 0.001);
% random_parameter = double(random_parameter);
% noisy_img = imnoise(input,'speckle',random_parameter);
% 
% NoiseLocation = fullfile(noisy_storage,sprintf('speckled.png'));
% imwrite(noisy_img,NoiseLocation);

% commented the above section after obatining the noisy image 

lee_in = im2double(noised);
lee_img = Leefilter(lee_in,5); % model predicted 5
lee_img = postpr(lee_img);

median_img = medfilt3(noised);

figure;
subplot(2,2,1);
imhist(input);
title("No speckle");

subplot(2,2,2);
imhist(noised);
title("With speckle");

subplot(2,2,3);
imhist(lee_img);
title("Lee Filter");

subplot(2,2,4);
imhist(median_img);
title("Median Filter");

function lee_output = Leefilter(img,window_size)

img = double(img);
lee_output = img;
means = imfilter(img, fspecial('average', window_size), 'replicate');
sigmas = sqrt((img-means).^2/window_size^2);
sigmas = imfilter(sigmas, fspecial('average', window_size), 'replicate');

ENLs = (means./sigmas).^2;
sx2s = ((ENLs.*(sigmas).^2) - means.^2)./(ENLs + 1);
fbar = means + (sx2s.*(img-means)./(sx2s + (means.^2 ./ENLs)));
lee_output(means~=0) = fbar(means~=0);

end

function post_out = postpr(a)
    mf = ones(3, 3)/9;
    meanfilt = imfilter(a,mf);
    c =imsharpen(meanfilt,'Radius',3,'Amount',3);
    post_out = imfilter(c,mf);
end

%Lee filter histogram resembles that of the unspeckled image the most