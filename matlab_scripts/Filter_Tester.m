clc
close all;
clear;

Storage_clean =dir(fullfile("C:","Users","Rohan Mahesh Rao","Desktop","DIP_project","New_images","clean","*.bmp"));
storage_noise = dir(fullfile("C:","Eng","Image-Despeckling","Noisy_Dataset_train","*.png"));

%filename = 'Specklefilter_Data_actual.xlsx';
%data = xlsread(filename,"E2:E551");

% I = imread("D:\Eng\Image-Despeckling\Dataset_train\clean8.png");
% clean = im2double(im2gray(I));
% input = imread("D:\Eng\Image-Despeckling\Noisy_Dataset_train\noise8.png");
% Inoise = im2double(input);
% Igray= im2gray(Inoise);

lee_2 = Leefilter(I_noisy,2);
lee_3 = Leefilter(I_noisy,3);
lee_4 = Leefilter(I_noisy,4);
lee_5 = Leefilter(I_noisy,5);
lee_6 = Leefilter(I_noisy,6);
lee_7 = Leefilter(I_noisy,7);
lee_8 = Leefilter(I_noisy,8);

output_lee_2 = postpr(lee_2);
output_lee_3 = postpr(lee_3);
output_lee_4 = postpr(lee_4);
output_lee_5 = postpr(lee_5);
output_lee_6 = postpr(lee_6);
output_lee_7 = postpr(lee_7);
output_lee_8 = postpr(lee_8);

[ssimval1,ssimmap1] = ssim(output_lee_2,I_clean);
[ssimval2,ssimmap2] = ssim(output_lee_3,I_clean);
[ssimval3,ssimmap3] = ssim(output_lee_4,I_clean);
[ssimval4,ssimmap4] = ssim(output_lee_5,I_clean);
[ssimval5,ssimmap5] = ssim(output_lee_6,I_clean);
[ssimval6,ssimmap6] = ssim(output_lee_7,I_clean);
[ssimval7,ssimmap7] = ssim(output_lee_8,I_clean);

disp(ssimval1);
disp(ssimval2);
disp(ssimval3);
disp(ssimval4);
disp(ssimval5);
disp(ssimval6);
disp(ssimval7);

% This is to plot the filtered images, their histograms and noisy image and
% its histogram 

%figure
%
% subplot(6,2,1)
% imshow(output_lee_3);
% title("Lee 3 Filter");
% subplot(6,2,2)
% histogram(output_lee_3)
% title("Lee 3 Filter histogram");
% 
% subplot(6,2,3)
% imshow(output_lee_4);
% title("Lee 4 Filter");
% subplot(6,2,4)
% histogram(output_lee_4);
% title("Lee 4 filter histogram");
% 
% subplot(6,2,5)
% imshow(output_lee_5);
% title("Lee 5 Filter");
% subplot(6,2,6)
% histogram(output_lee_5);
% title("Lee 5 filter histogram");
% 
% subplot(6,2,7)
% imshow(output_lee_6);
% title("Lee 6 Filter");
% subplot(6,2,8)
% histogram(output_lee_6);
% title("Lee 6 filter histogram");
% 
% subplot(6,2,9)
% imshow(output_lee_7);
% title("Lee 7 Filter");
% subplot(6,2,10)
% histogram(output_lee_7)
% title("Lee 7 Filter histogram");
% 
% subplot(6,2,11);
% imshow(Igray);
% title("Noisy Image");
% subplot(6,2,12)
% histogram(Igray)
% title("Noisy image histogram");

% for loop to find SSI and the corresponding values

% for n = 1:length(storage_noise)  
%     Iclean = imread("D:\Eng\Image-Despeckling\Dataset_train\clean"+num2str(n)+".png");
%     Inoisy = imread("D:\Eng\Image-Despeckling\Noisy_Dataset_train\noise"+num2str(n)+".png");
%     
%     I_clean = im2double(im2gray(Iclean));
%     I_noisy = im2double(im2gray(Inoisy));
%     
%     lee_2 = Leefilter(I_noisy,2);
%     lee_3 = Leefilter(I_noisy,3);
%     lee_4 = Leefilter(I_noisy,4);
%     lee_5 = Leefilter(I_noisy,5);
%     lee_6 = Leefilter(I_noisy,6);
%     lee_7 = Leefilter(I_noisy,7);
%     lee_8 = Leefilter(I_noisy,8);
%     
%     output_lee_2 = postpr(lee_2);
%     output_lee_3 = postpr(lee_3);
%     output_lee_4 = postpr(lee_4);
%     output_lee_5 = postpr(lee_5);
%     output_lee_6 = postpr(lee_6);
%     output_lee_7 = postpr(lee_7);
%     output_lee_8 = postpr(lee_8);
%     
%     [ssimval1,ssimmap1] = ssim(output_lee_2,I_clean);
%     [ssimval2,ssimmap2] = ssim(output_lee_3,I_clean);
%     [ssimval3,ssimmap3] = ssim(output_lee_4,I_clean);
%     [ssimval4,ssimmap4] = ssim(output_lee_5,I_clean);
%     [ssimval5,ssimmap5] = ssim(output_lee_6,I_clean);
%     [ssimval6,ssimmap6] = ssim(output_lee_7,I_clean);
%     [ssimval7,ssimmap7] = ssim(output_lee_8,I_clean);
% 
%     ssimvalues = [ssimval1,ssimval2,ssimval3,ssimval4,ssimval5,ssimval6,ssimval7]; % list of SSIM values for 7 window sizes
%     win_size = data(n); % values from the xlsx file of window sizes
%     s = win_size-1;
%     ssivals = ssimvalues(1,s); %SSI value of that particular window size what we chose 
%     maxval = max(ssimvalues); %max SSi value for that image 
%     index = find(ssimvalues==maxval); %stores the index of the max value
%     kernel = index + 1; % to get the window size which gives the max ssim 
%     
%     ssivals_list(:,n) = round(ssivals,3);% makes the list of the ssi vals of the window which we chose
%     maxlist(:,n) = round(maxval,3); % makes the list of the max SSI value for a particular image
%     kernel_list(:,n) = kernel;  % list of best window size 
% 
% end


% for writing SSIM and best window to the excel file 

% for row = 1:550
%     xlswrite('towrite.xlsx', maxlist(row), 'Sheet1', ['A' num2str(row)]);
%     xlswrite('towrite.xlsx', ssivals_list(row), 'Sheet1', ['B' num2str(row)]);
%     xlswrite('towrite.xlsx', kernel_list(row), 'Sheet1', ['C' num2str(row)]);
% 
% end

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
    c =imsharpen(meanfilt,'Radius',3.5,'Amount',3.5);
    post_out = imfilter(c,mf);
end



