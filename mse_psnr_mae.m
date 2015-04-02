clc
clear
img2 = imread('C:\Users\Nikhil\Documents\MATLAB\watermarked_img.jpg');
img1 = imread('C:\Users\Nikhil\Documents\MATLAB\cover.jpg');
[irow icol dim]=size(img1);
sum =0;
for i=1:size(img1,1)
    for j=1:size(img1,2)
       sum = sum + double((img1(i,j,1)-img2(i,j,1)) + (img1(i,j,2)-img2(i,j,2)) + (img1(i,j,3)-img2(i,j,3)));
    end
end
mse=double(sum)/(3*size(img1,1)*size(img1,2))

    
psnr=10*log10(255*255/mse)


img3 = imread('C:\Users\Nikhil\Documents\MATLAB\watermark.jpg');
img3=imresize(img3,[32 32]);
img4 = imread('C:\Users\Nikhil\Documents\MATLAB\retrieve.jpg');
[irow icol dim] = size(img3);
 img3=rgb2gray(img3);
 img3=im2bw(img3,0.5);
 img4=im2bw(img4,0.5);
 sum =0;
w= reshape(img3,irow*icol,1);
 s= reshape(img4,irow*icol,1);
 for i=1:size(w)
     if(~(w(i)==s(i)))
         sum=sum+1;
     end
 end
mae=double(sum)/(size(img3,1)*size(img3,2))
