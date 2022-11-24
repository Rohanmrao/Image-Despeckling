
Noisy_set  = "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Noisy_Dataset\";
Clean_set =  "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Dataset\";
Storage =dir(fullfile("C:","Users","Rohan Mahesh Rao","Desktop","DIP_project","Noisy_Dataset","*.png"));
fprintf("No.of images in the clean set: %d",numel(Storage));

for k = 1: numel(Storage)
    Files = fullfile(Clean_set,Storage(k).name);
    Input = imread(Files);
    Storage(k).data = Input;
end
for j = 1:length(Storage)
    ImageData = Storage(j).data;

    I_hsv = rgb2hsv(ImageData);
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
    Bval = mean(mean(I_lab(:,:,3))); %extracting LAB features


    filename = 'C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\temp_hsv.xlsx';
    writecell(C,filename,'Sheet','Temperatures','Range','B2');

end 
