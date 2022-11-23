% creating the model here using a convolutional neural network


Noisy_set  = "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Noisy_Dataset\";
Clean_set =  "C:\Users\Rohan Mahesh Rao\Desktop\DIP_project\Dataset\";
Noisy_Storage =dir(fullfile("C:","Users","Rohan Mahesh Rao","Desktop","DIP_project","Noisy_Dataset","*.png"));
fprintf("No.of images in the clean set: %d",numel(Noisy_Storage)); % no. of Noisy images

Filtered_imgs = Noisy_Storage + filesp + "Processed_Dataset";
