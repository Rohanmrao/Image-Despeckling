close;
clear;

input = imread("Noisy_dataset/noise3.png");
Inoise = im2double(input);
I_hsv = rgb2hsv(input);

hueval = 10*mean(mean(I_hsv(:,:,1))); 
scaleval = 10*mean(mean(I_hsv(:,:,2)));
valval = 10*mean(mean(I_hsv(:,:,3))); % extracting hsv features of the image for it to act as a unique image signature

imax = max(Inoise(:));
imin = min(Inoise(:));
ims = std(Inoise(:));
snr_val = log((imax - imin) ./ ims); % extracting snr and scaling it down by ten 

I_lab = rgb2lab(input);
Lval = mean(mean(I_lab(:,:,1)));
Aval = mean(mean(I_lab(:,:,2)));
Bval = mean(mean(I_lab(:,:,2)));


fprintf("SNR value : %d\n",snr_val);
fprintf("Hue : %d | Scale : %d | Value : %d\n",hueval,scaleval,valval);
fprintf("L : %d | A : %d | B : %d\n",Lval,Aval,Bval);

output_lee = Leefilter(Inoise,4);

figure;
subplot(1,2,1)
imshow(output_lee);
title("Lee Filter");
subplot(1,2,2);
imshow(Inoise);
title("Noisy Image");

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




