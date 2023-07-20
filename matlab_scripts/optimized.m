clc
close all;
clear all;

%This code is to write the image features into excel file

clean_folder = "D:\Eng\Image-Despeckling\New_images\clean_rename\";
noisy_folder = "D:\Eng\Image-Despeckling\New_images\noisy\";

storage_clean = dir(fullfile(clean_folder, "*.png")); % stores the full directory of clean images
storage_noise = dir(fullfile(noisy_folder, "*.png")); % stores the full directory of niosy images

num_images = length(storage_noise); % number of images in the directory

% Initiallising all list to be used, so that the length doesn't change
% every time the for loop runs 

hueval_list = zeros(1, num_images); % store hue value of the image
scaleval_list = zeros(1, num_images);
valval_list = zeros(1, num_images);
maxlist = zeros(1, num_images);
kernel_list = zeros(1, num_images);
n_list = zeros(1,num_images);

%main loop 
for n = 1:num_images
    Iclean = imread(fullfile(clean_folder, storage_clean(n).name));
    Inoisy = imread(fullfile(noisy_folder, storage_noise(n).name));

    I_clean = im2double(Iclean);
    I_noisy = im2double(Inoisy);
    
    ImageData = Inoisy;
    I_hsv = rgb2hsv(ImageData);
    hueval = 10 * mean(mean(I_hsv(:, :, 1)));
    scaleval = 10 * mean(mean(I_hsv(:, :, 2)));
    valval = 10 * mean(mean(I_hsv(:, :, 3)));

    hueval = round(hueval, 1);
    scaleval = round(scaleval, 1);
    valval = round(valval, 1);

    hueval_list(n) = uint8(hueval);
    scaleval_list(n) = uint8(scaleval);
    valval_list(n) = uint8(valval);

    % Calculate Lee filters for different window sizes
    lee_output = cell(1, 7);
    for window_size = 2:8
        lee_output{window_size - 1} = Leefilter(I_noisy, window_size);
    end

    % Post-process Lee filters and calculate SSIM values
    ssim_values = zeros(1, 7);
    for i = 1:7
        output_lee = imsharpen(lee_output{i});
        [ssim_values(i), ~] = ssim(output_lee, I_clean);
    end

    % Find the maximum SSIM value and its corresponding kernel
    [maxval, kernel] = max(ssim_values);
    maxlist(n) = round(maxval, 3);
    kernel_list(n) = kernel + 1;
    n_list(n) = n;
end

% Create a table from the data
data = [hueval_list', scaleval_list', valval_list', maxlist', kernel_list'];
headers = {'Hue Value', 'Scale Value', 'Value Value', 'Max SSIM', 'Best Window Size'};
T = array2table(data, 'VariableNames', headers);

% Write the table to an Excel file
excel_file = 'output_data.xlsx';
writetable(T, excel_file);

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

% function post_out = postpr(a)
%     mf = ones(3, 3)/9;
%     meanfilt = imfilter(a,mf);
%     c =imsharpen(meanfilt,'Radius',3.5,'Amount',3.5);
%     post_out = imfilter(c,mf);
% end

