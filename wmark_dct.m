%Non-Blind WaterMarking
clc;
clear all;
close all;
x=double(imread('greens.jpg'));
figure,imshow(x/255);
y=x;
[h w b]=size(x);
a=zeros(h,w);
a(100:250,100:350)=1;
figure,imshow(a);
x1=x(:,:,1);
x2=x(:,:,2);
x3=x(:,:,3);

dx1=dct2(x1);dx11=dx1;
dx2=dct2(x2);dx22=dx2;
dx3=dct2(x3);dx33=dx3;

q=10;
[rm cm]=size(a);
dx1=dx1+q*a;
dx2=dx2+q*a;
dx3=dx3+q*a;

figure, imshow(dx1);
figure, imshow(dx2);
figure, imshow(dx3);

y1=idct2(dx1);
y2=idct2(dx2);
y3=idct2(dx3);

y(:,:,1)=y1;
y(:,:,2)=y2;
y(:,:,3)=y3;

figure, imshow(y1/255);
figure, imshow(y2/255);
figure, imshow(y3/255);
figure,imshow(y/255);
figure,imshow(abs(y-x)*100);

%de-watermarking
dy1=dct2(y(:,:,1));
dy2=dct2(y(:,:,2));
dy3=dct2(y(:,:,3));

dy1=dy1-q*a;
dy2=dy2-q*a;
dy3=dy3-q*a;

y11=idct2(dy1);
y22=idct2(dy2);
y33=idct2(dy3);

ans(:,:,1)=y11;
ans(:,:,2)=y22;
ans(:,:,3)=y33;

figure,imshow(ans/255);
figure,imshow(abs(ans-x)*100);
