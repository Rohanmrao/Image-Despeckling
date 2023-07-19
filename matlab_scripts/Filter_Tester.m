clc
close all;
clear all;

storage_clean = dir(fullfile("D:","Eng","Image-Despeckling","New_images","clean_rename","*.png"));
storage_noise = dir(fullfile("D:","Eng","Image-Despeckling","New_images","noisy","*.png"));

% for loop to find SSI and the corresponding values

for n = 1:length(storage_noise) 
    Iclean = imread("D:\Eng\Image-Despeckling\New_images\clean_rename\clean"+num2str(n)+".png");
    Inoisy = imread("D:\Eng\Image-Despeckling\New_images\noisy\speckled"+num2str(n)+".png");
    
    I_clean = im2double(im2gray(Iclean));
    I_noisy = im2double(im2gray(Inoisy));

    ImageData = storage_noise(n).data;

    I_hsv = rgb2hsv(ImageData);
    hueval = 10*mean(mean(I_hsv(:,:,1))); 
    scaleval = 10*mean(mean(I_hsv(:,:,2)));
    valval = 10*mean(mean(I_hsv(:,:,3))); % extracting hsv features of the image for it to act as a unique image signature

    hueval = round(hueval,1);
    scaleval = round(scaleval,1);
    valval = round(valval,1);

%   hueval = uint8(hueval);
%   scaleval = uint8(scaleval);
%   valval = uint8(valval);
    
    hueval_list(n) = hueval;
    scaleval_list(n) = scaleval;
    valval_list(n) = valval;
    
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

    ssimvalues = [ssimval1,ssimval2,ssimval3,ssimval4,ssimval5,ssimval6,ssimval7]; % list of SSIM values for 7 window size
    maxval = max(ssimvalues); %max SSi value for that image 
    index = find(ssimvalues==maxval); %stores the index of the max value
    kernel = index + 1; % to get the window size which gives the max ssim 
    maxlist(:,n) = round(maxval,3); % makes the list of the max SSI value for a particular image
    kernel_list(:,n) = kernel;  % list of best window size 


end


% for writing SSIM and best window to the excel file 

for row = 1:1601

    xlswrite('newsheet.xlsx', hueval_list(row), 'Sheet1', ['A' num2str(row)]);
    xlswrite('newsheet.xlsx', scaleval_list(row), 'Sheet1', ['B' num2str(row)]);
    xlswrite('newsheet.xlsx', valval_list(row), 'Sheet1', ['C' num2str(row)]);
    xlswrite('towrite1.xlsx', maxlist(row), 'Sheet1', ['D' num2str(row)]);
    xlswrite('towrite1.xlsx', kernel_list(row), 'Sheet1', ['E' num2str(row)]);

end

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



