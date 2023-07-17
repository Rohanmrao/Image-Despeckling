Storage =dir(fullfile("C:","Users","Rohan Mahesh Rao","Desktop","Dip","New_images","noisy","*.png"));
fprintf("No.of images in the clean set: %d",numel(Storage));

for k = 1: numel(Storage)
    Files = fullfile(Noisy_set,Storage(k).name);
    input = imread(Files);
    Storage(k).data = input;
end

for j = 1:length(Storage)
    ImageData = Storage(j).data;

    I_hsv = rgb2hsv(ImageData);
    hueval = 10*mean(mean(I_hsv(:,:,1))); 
    scaleval = 10*mean(mean(I_hsv(:,:,2)));
    valval = 10*mean(mean(I_hsv(:,:,3))); % extracting hsv features of the image for it to act as a unique image signature

    hueval = round(hueval,1);
    scaleval = round(scaleval,1);
    valval = round(valval,1);

    hueval = uint8(hueval);
    scaleval = uint8(scaleval);
    valval = uint8(valval);
    
    towrite = {j,hueval,scaleval,valval};
    writecell(towrite,'towrite.xlsx','WriteMode','append');

end 