
function pseudo_image = Pseudo_Image(A)
    A = im2gray(A);
    [row,col]=size(A);
    for i=1:1:row
     for j=1:1:col
     if (A(i,j)>= 0) && (A(i,j) < 25)
     red(i,j)=255;
     green(i,j)=0;
     blue(i,j)=0;
     elseif (A(i,j)>= 25) && (A(i,j)< 50)
     red(i,j)=150;
     green(i,j)=51;
     blue(i,j)=0;
      elseif (A(i,j)>= 50) && (A(i,j)< 75)
     red(i,j)=102;
     green(i,j)=102;
     blue(i,j)=0;
      elseif (A(i,j)>= 75) && (A(i,j)< 100)
     red(i,j)=80;
     green(i,j)=153;
     blue(i,j)=0;
      elseif (A(i,j)>= 100) && (A(i,j)< 125)
     red(i,j)=51;
     green(i,j)=204;
     blue(i,j)=0;
      elseif (A(i,j)>= 125) && (A(i,j)< 150)
     red(i,j)=0;
     green(i,j)=255;
     blue(i,j)=0;
      elseif (A(i,j)>= 150) && (A(i,j)< 175)
     red(i,j)=0;
     green(i,j)=192;
     blue(i,j)=120;
      elseif (A(i,j)>= 175) && (A(i,j)< 200)
     red(i,j)=0;
     green(i,j)=129;
     blue(i,j)=180;
      elseif (A(i,j)>= 200) && (A(i,j)< 225)
     red(i,j)=0;
     green(i,j)=66;
     blue(i,j)=200;
     elseif (A(i,j) >= 225) && (A(i,j)< 255)
     red(i,j)=0;
     green(i,j)=0;
     blue(i,j)=255;
     end
     end
     end
    
    pseudo_image=cat(3,red,green,blue);
    pseudo_image=pseudo_image/255;%convert from 0-255 to 0-1

end