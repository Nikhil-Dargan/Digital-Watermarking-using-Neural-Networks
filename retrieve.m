%function fn = retrieve(X,irow,icol);
watermark = imread('C:\Users\Nikhil\Documents\MATLAB\watermark.jpg');
watermark=imresize(watermark,[32 32]);

watermarked_img = imread('C:\Users\Nikhil\Documents\MATLAB\watermarked_img.jpg');
[irow icol dim] = size(watermark);
watermark=rgb2gray(watermark);
watermark=im2bw(watermark,0.5);
w = reshape(watermark,irow*icol,1);   
X=[];
rng(1,'twister');
for i=1:size(w,1)
    for j=1:7
        r_range=[5 507];
        x=randi(r_range,1,1);
        y=randi(r_range,1,1);
        temp=[];
        a=delta(watermarked_img,x,y);
        temp=[double(a)];
        for j=-2:2
             if(j~=0)
                 temp=[temp ; double(delta(watermarked_img,x+j,y))];  
             end
        end
        for j=-2:2
             if(j~=0)
                 temp=[temp ; double(delta(watermarked_img,x,y-j))];  
             end
        end
        X=[X double(temp)];
    end
end
%%%%%%%%%%%%%%%%%%%%%%
global net
out=net(X);
%count1=0;
for i=1:size(out,2)
     if(out(i)>0)
         out(i)=1;
         %count1=count1+1;
     else
         out(i)=0;
     end
end
j=0;
out2=[];

'bbbbbbbbbbbb'
size(out,2)
for i=[1:7:size(out,2)]
    j=j+1;
    t=[out(i) out(i+1) out(i+2) out(i+3) out(i+4) out(i+5) out(i+6)];
    out2(j)=mode(t);
    
end

irow
icol
size(out2,2);
w = reshape(out2,irow,icol);   
[w map]=gray2ind(w,255);
imwrite(uint8(w), 'retrieve.jpg'); 
I = imread('retrieve.jpg'); 
imshow(I)
accuracy();
% T = imread('watermark.jpg'); 
% imshow(T)
% 
