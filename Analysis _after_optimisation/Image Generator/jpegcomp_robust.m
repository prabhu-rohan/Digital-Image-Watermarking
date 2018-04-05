clc;
clear all;
close all;
a=imread('C:\Users\Rohan Prabhu\Downloads\lenna.jpg');
wirgb=imread('C:\Users\Rohan Prabhu\Downloads\logo.jpg');
wi=rgb2gray(wirgb);
w=double(wi);
[ll lh hl hh]=dwt2(a,'haar');
[ull sll vll]=svd(ll);
[ulh slh vlh]=svd(lh);
[uhl shl vhl]=svd(hl);
[uhh shh vhh]=svd(hh);

sll2=sll+0.04035*w;
slh2=slh+0.006647*w;
shl2=shl+0.018071*w;
shh2=shh+0.010143*w;

[sll21 sll22 sll23]=svd(sll2);
[slh21 slh22 slh23]=svd(slh2);
[shl21 shl22 shl23]=svd(shl2);
[shh21 shh22 shh23]=svd(shh2);

imgll=ull*sll22*vll';
imglh=ulh*slh22*vlh';
imghl=uhl*shl22*vhl';
imghh=uhh*shh22*vhh';

sz=size(a);
imgaw=idwt2(imgll,imglh,imghl,imghh,'haar',sz);

figure
imshow(a);
ac=uint8(imgaw);
figure
imshow(ac);
%de-watermarking
%i/p=imgaw,sll,slh,shl,shh,sll21,sll23,slh21,slh23,shl21,shl23,slh21,slh23,shh21,shh23

mkdir('New Folder');
imwrite(ac,'New Folder/n1.jpg','Quality',10);
naci=imread('New Folder/n1.jpg');
nac=double(naci);
figure 
imshow(nac/255);

[dll dlh dhl dhh]=dwt2(nac,'haar');

[udll sdll vdll]=svd(dll);
[udlh sdlh vdlh]=svd(dlh);
[udhl sdhl vdhl]=svd(dhl);
[udhh sdhh vdhh]=svd(dhh);

d1=sll21*sdll*sll23';
d2=slh21*sdlh*slh23';
d3=shl21*sdhl*shl23';
d4=shh21*sdhh*shh23';

o1=(d1-sll)./0.04035;
o2=(d2-slh)./0.006647;
o3=(d3-shl)./0.018071;
o4=(d4-shh)./0.010143;
figure
imshow(wi);

o1i=uint8(o1);
corr2(o1i,wi)
o2i=uint8(o2);
corr2(o2i,wi)
o3i=uint8(o3);
corr2(o3i,wi)
o4i=uint8(o1);
corr2(o4i,wi)

figure
imshow([o1/255 o2/255;o3/255 o4/255]);

psnr1=psnr(ac,a)
