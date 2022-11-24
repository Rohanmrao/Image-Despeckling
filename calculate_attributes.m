
Noisy_set  = "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Noisy_Dataset\";
Clean_set =  "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Dataset\";
Storage =dir(fullfile("C:","Users","Rohan Mahesh Rao","Desktop","DIP_project","Noisy_Dataset","*.png"));
fprintf("No.of images in the clean set: %d",numel(Storage));

for k = 1: numel(Storage)
    Files = fullfile(Noisy_set,Storage(k).name);
    input = imread(Files);
    Storage(k).data = input;
end

for j = 1:length(Storage)
    ImageData = Storage(j).data;

    r = mean(mean(input(:,:,1)));
    g = mean(mean(input(:,:,2)));
    b = mean(mean(input(:,:,3)));

    I_hsv = rgb2hsv(ImageData);
    hueval = 10*mean(mean(I_hsv(:,:,1))); 
    scaleval = 10*mean(mean(I_hsv(:,:,2)));
    valval = 10*mean(mean(I_hsv(:,:,3))); % extracting hsv features of the image for it to act as a unique image signature
    
    I_lab = rgb2lab(input);
    Lval = mean(mean(I_lab(:,:,1))); %extracting Lightness

    towrite = {j,hueval,scaleval,valval,Lval,r,g,b};
    writecell(towrite,'towrite.xlsx','WriteMode','append');

end 