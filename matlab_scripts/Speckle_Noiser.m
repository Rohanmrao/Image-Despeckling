% MATLAB DIP PROJECT - 
% Creating a model to remove speckling noise in a SAR image, using a DT
% regressorcd

Noisy_set  = "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\New_images\noisy\";
Clean_set =  "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\New_images\clean\";
Storage_bmp =dir(fullfile("C:","Users","Rohan Mahesh Rao","Desktop","DIP_project","New_images","clean","*.bmp"));
Storage_png =dir(fullfile("C:","Users","Rohan Mahesh Rao","Desktop","DIP_project","New_images","clean","*.png"));
Storage_jpg =dir(fullfile("C:","Users","Rohan Mahesh Rao","Desktop","DIP_project","New_images","clean","*.jpg"));

bmp_count = numel(Storage_bmp);
png_count = numel(Storage_png);
jpg_count = numel(Storage_jpg);
total_count = bmp_count + png_count + jpg_count ;

fprintf("No.of images in the clean set: %d\n",(total_count));
fprintf("bmp : %d\n",bmp_count);
fprintf("png : %d\n",png_count);
fprintf("jpg : %d\n",jpg_count);

counter = 1 ;

for k = 1 : png_count
    Files = fullfile(Clean_set,Storage_png(k).name);
    Input = imread(Files);
    Storage_png(k).data = Input;
end

for j = 1 : png_count
    ImageData = Storage_png(j).data;
    %apply noise
    random_parameter = 0.01 + rand*(1.0 - 0.001);
    disp(random_parameter);
    ApplyNoise = imnoise(ImageData,'speckle',random_parameter);
    %save images in the right folder
    NoiseLocation = fullfile(Noisy_set,sprintf('speckled%d.png',counter));
    imwrite(ApplyNoise,NoiseLocation);
    counter = counter + 1;
end 

for k = 1 : jpg_count
    Files = fullfile(Clean_set,Storage_jpg(k).name);
    Input = imread(Files);
    Storage_jpg(k).data = Input;
end

for j = 1 : jpg_count
    ImageData = Storage_jpg(j).data;
    %apply noise
    random_parameter = 0.01 + rand*(1.0 - 0.001);
    disp(random_parameter);
    ApplyNoise = imnoise(ImageData,'speckle',random_parameter);
    %save images in the right folder
    NoiseLocation = fullfile(Noisy_set,sprintf('speckled%d.png',counter));
    imwrite(ApplyNoise,NoiseLocation);
    counter = counter + 1 ;
end 

for k = 1 : bmp_count
    Files = fullfile(Clean_set,Storage_bmp(k).name);
    Input = imread(Files);
    Storage_bmp(k).data = Input;
end

for j = 1 : bmp_count
    ImageData = Storage_bmp(j).data;
    %apply noise
    random_parameter = 0.01 + rand*(1.0 - 0.001);
    disp(random_parameter);
    ApplyNoise = imnoise(ImageData,'speckle',random_parameter);
    %save images in the right folder
    NoiseLocation = fullfile(Noisy_set,sprintf('speckled%d.png',counter));
    imwrite(ApplyNoise,NoiseLocation);
    counter = counter + 1;
end






