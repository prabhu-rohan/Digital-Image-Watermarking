clc;
clear all;
close all;
a=zeros(256,256);
a(73:173,73:173)=1;
figure
imshow(a);
af=fft2(a);
af1=log(1+abs(af));
fm=max(af1(:));
figure
imshow(im2uint8(af1/fm));
figure
imshow(mat2gray(log(1+abs(af1))));
%new
clc;
clear all;
close all;
[X Y]=meshgrid(-128:127,-128:127);
Z=sqrt(X.^2+Y.^2);
c=(Z<25);
figure
imshow(c);
cf=fftshift(fft2(c));
cf1=log(1+abs(cf));
m=max(cf1(:));
figure 
imshow(im2uint8(cf1/m));