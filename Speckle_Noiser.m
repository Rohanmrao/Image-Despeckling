% MATLAB DIP PROJECT - 
% Creating a model to remove speckling noise in a SAR image, using a
% trained CNN

Noisy_set  = "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Testset\speckled\";
Clean_set =  "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Testset\clean\";
Storage =dir(fullfile("C:","Users","Rohan Mahesh Rao","Desktop","DIP_project","Testset","clean","*.png"));
fprintf("No.of images in the clean set: %d",numel(Storage));

for k = 1: numel(Storage)
    Files = fullfile(Clean_set,Storage(k).name);
    Input = imread(Files);
    Storage(k).data = Input;
end

for j = 1:length(Storage)
    ImageData = Storage(j).data;
    %apply noise
    random_parameter = 0.01 + rand*(1.0 - 0.001);
    disp(random_parameter);
    ApplyNoise = imnoise(ImageData,'speckle',random_parameter);
    %save images in the right folder
    NoiseLocation = fullfile(Noisy_set,sprintf('speckled%d.png',j));
    imwrite(ApplyNoise,NoiseLocation);
end 
