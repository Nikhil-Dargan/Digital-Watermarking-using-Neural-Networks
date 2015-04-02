clc
clear
img = imread('C:\Users\Nikhil\Documents\MATLAB\cover2.tif');
watermark = imread('C:\Users\Nikhil\Documents\MATLAB\logo2.jpg');
imwrite(uint8(watermark), 'watermark.jpg'); 
watermark=imresize(watermark,[32 32]);
img=imresize(img,[512 512]);
imwrite(uint8(img), 'cover.jpg'); 
imshow(watermark)
aplha=20.0;
[irow icol dim] = size(watermark);
 watermark=rgb2gray(watermark);
watermark=im2bw(watermark,0.5);
w = reshape(watermark,irow*icol,1); 
rng(1,'twister');
for i=1:size(w,1)
    %r_range=[5 670];
    r_range=[5 507];
    %r_range=[5 220];
    for j=1:7
        x=randi(r_range,1,1);
        y=randi(r_range,1,1);
        r=img(x,y,1);
        g=img(x,y,2);
        b=img(x,y,3);
        l=(0.299*r)+(0.587*g)+(0.114*b);
        img(x,y,2)=b+(2*w(i)-1)*aplha*l;
    end
end
disp('aaa');
%img=imrotate(img,-30);
imwrite(uint8(img), 'watermarked_img.jpg'); 
I = imread('watermarked_img.jpg'); 
imshow(I) 


function del = delta(img,x,y);

    b=img(x,y,3);
    b1 = [img(x-2,y,3)];
    b1 = [b1  img(x-1,y,3)];
    b1 = [b1  img(x+1,y,3)];
    b1 = [b1  img(x+2,y,3)];
    b1 = [b1  img(x,y-2,3)];
    b1 = [b1  img(x,y-1,3)];
    b1 = [b1  img(x,y+1,3)];
    b1 = [b1  img(x,y+2,3)];
    del=double(b)-(sum(b1)/8);
