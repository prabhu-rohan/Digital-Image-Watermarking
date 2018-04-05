clc;
clear all;
close all;
r=100;
a=imread('cameraman.tif');
figure
imshow(a);
af=fftshift(fft2(a));
fftshow(af);
[x y]=meshgrid([-128:127],[-128:127]);
z=sqrt(x.^2+y.^2);
c=z<r;
figure
imshow(c);
af1=af.*c;
fftshow(af1);
afi=ifft2(af1);
ifftshow(afi);