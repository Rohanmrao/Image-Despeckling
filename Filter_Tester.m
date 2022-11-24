close;
clear;

input = imread("Noisy_dataset/noise164.png");
Inoise = im2double(input);

output_lee_2 = Leefilter(Inoise,2);
output_lee_3 = Leefilter(Inoise,3);
output_lee_4 = Leefilter(Inoise,4);
output_lee_5 = Leefilter(Inoise,5);
output_lee_6 = Leefilter(Inoise,6);

figure;
subplot(2,2,1)
imshow(output_lee_3);
title("Lee 3 Filter");
subplot(2,2,2)
imshow(output_lee_4);
title("Lee 4 Filter");
subplot(2,2,3)
imshow(output_lee_5);
title("Lee 5 Filter");
subplot(2,2,4);
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




