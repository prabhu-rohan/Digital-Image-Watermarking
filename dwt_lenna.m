clc;
clear all;
close all;
a=imread('C:\Users\Rohan Prabhu\Downloads\lenna.jpg');
[ll lh hl hh]=dwt2(a,'haar');
figure;
imshow(a);
%hh=double(imread('cameraman.tif'));
figure;
imshow([ll/255 lh/255;hl/255 hh/255]);
[lhll lhlh lhhl lhhh]=dwt2(lh,'haar');
level2=[lhll lhlh;lhhl lhhh];
figure
imshow([ll/255 level2/255;hl/255 hh/255]);
[hlll hllh hlhl hlhh]=dwt2(hl,'haar');
level2a=[hlll hllh;hlhl hlhh];
figure
imshow([ll/255 level2/255;level2a/255 hh/255]);
sa=size(a);
ad=idwt2(ll,lh,hl,hh,'haar',sa);
figure
imshow(ad/255);

