clc
clear
watermark = imread('C:\Users\Nikhil\Documents\MATLAB\watermark.jpg');
watermark=imresize(watermark,[32 32]);
watermarked_img = imread('C:\Users\Nikhil\Documents\MATLAB\watermarked_img.jpg');
[irow icol dim] = size(watermark);
 watermark=rgb2gray(watermark);
 watermark=im2bw(watermark,0.5);
w = reshape(watermark,irow*icol,1);  
X=[];
T=[];
rng(1,'twister');
count=0;
count2=0;
%size(w,1)
for i=1:size(w,1)
%for i=1:2000
    %i=1;
    %r_range=[5 670];
    for j=1:7
        r_range=[5 507];
        x=randi(r_range,1,1);
        %r_range=[5 445];
        %r_range=[5 220];-
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
        dt=double(watermarked_img(x,y,3)-a)/255;
        if(w(i)==0)
            dt=double(-dt);
            count=count+1;
        end
         count2=count2+1;
        if(~any(temp))
            continue;
        end
        X=[X double(temp)];
        T = [T double(dt)];
    end
end
count
count2
global net
setdemorandstream(391418381)
% newff(double(X),double(T),[5],('transig'),('traingd'));
% net=configure(net,X,T);

net= patternnet(5);
net.trainParam.epochs=50;
net.trainParam.lr=0.1;
net.trainParam.max_fail=200;
%net.divideParam.valRatio=0;
[net,tr] = train(net,double(X),double(T));
