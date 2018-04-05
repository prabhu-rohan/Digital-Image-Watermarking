clc;
clear all;
close all;
a=imread('C:\Users\Rohan Prabhu\Downloads\lenna.jpg');
wirgb=imread('C:\Users\Rohan Prabhu\Downloads\logo.jpg');
wi=rgb2gray(wirgb);
w=double(wi);
[ll lh hl hh]=dwt2(a,'haar');
%[ull sll vll]=svd(ll);
 [ulh slh vlh]=svd(lh);
% [uhl shl vhl]=svd(hl);
% [uhh shh vhh]=svd(hh);

%sll2=sll+0.05*w;
 slh2=slh+0.005*w;
% shl2=shl+0.005*w;
% shh2=shh+0.005*w;

%[sll21 sll22 sll23]=svd(sll2);
 [slh21 slh22 slh23]=svd(slh2);
% [shl21 shl22 shl23]=svd(shl2);
% [shh21 shh22 shh23]=svd(shh2);

%imgll=ull*sll22*vll';
 imglh=ulh*slh22*vlh';
% imghl=uhl*shl22*vhl';
% imghh=uhh*shh22*vhh';

sz=size(a);
imgaw=idwt2(ll,imglh,hl,hh,'haar',sz);

figure
imshow(a);
figure
imshow([ll/255 lh/255;hl/255 hh/255]);
ac=uint8(imgaw);
figure
imshow(ac);
%de-watermarking
%i/p=imgaw,sll,slh,shl,shh,sll21,sll23,slh21,slh23,shl21,shl23,slh21,slh23,shh21,shh23

nac_rot=imrotate(ac,45,'bilinear','crop');
figure 
imshow(nac_rot);

nac_tran=imtranslate(ac,[10,25]);
figure 
imshow(nac_tran);

nac_sp=imnoise(ac,'salt & pepper',0.1);
figure 
imshow(nac_sp);

nac_speckle=imnoise(ac,'speckle',0.1);
figure 
imshow(nac_speckle);

nac_gaussian_noise=imnoise(ac,'gaussian',0.1);
figure 
imshow(nac_gaussian_noise);

nac_gaussian_filter=imgaussfilt(ac,2);
figure 
imshow(nac_gaussian_filter);

nac_median_filter=medfilt2(ac,[5 5]);
figure 
imshow(nac_median_filter);

nac_center_crop=ac;
nac_center_crop(206:306,206:306)=0;
figure 
imshow(nac_center_crop);

nac_hist_eq=histeq(ac);
figure
imshow(nac_hist_eq);


[dll dlh dhl dhh]=dwt2(imgaw,'haar');

[dll1 dlh1 dhl1 dhh1]=dwt2(nac_rot,'haar');
[dll2 dlh2 dhl2 dhh2]=dwt2(nac_tran,'haar');
[dll3 dlh3 dhl3 dhh3]=dwt2(nac_sp,'haar');
[dll4 dlh4 dhl4 dhh4]=dwt2(nac_speckle,'haar');
[dll5 dlh5 dhl5 dhh5]=dwt2(nac_gaussian_noise,'haar');
[dll6 dlh6 dhl6 dhh6]=dwt2(nac_gaussian_filter,'haar');
[dll7 dlh7 dhl7 dhh7]=dwt2(nac_median_filter,'haar');
[dll8 dlh8 dhl8 dhh8]=dwt2(nac_center_crop,'haar');
[dll9 dlh9 dhl9 dhh9]=dwt2(nac_hist_eq,'haar');


[udlh sdlh vdlh]=svd(dlh);

[udll1 sdll1 vdll1]=svd(dlh1);
[udll2 sdll2 vdll2]=svd(dlh2);
[udll3 sdll3 vdll3]=svd(dlh3);
[udll4 sdll4 vdll4]=svd(dlh4);
[udll5 sdll5 vdll5]=svd(dlh5);
[udll6 sdll6 vdll6]=svd(dlh6);
[udll7 sdll7 vdll7]=svd(dlh7);
[udll8 sdll8 vdll8]=svd(dlh8);
[udll9 sdll9 vdll9]=svd(dlh9);

% d1=sll21*sdll*sll23';
  d1=slh21*sdlh*slh23';
% d3=shl21*sdhl*shl23';
% d4=shh21*sdhh*shh23';
d2=slh21*sdll1*slh23';
d3=slh21*sdll2*slh23';
d4=slh21*sdll3*slh23';
d5=slh21*sdll4*slh23';
d6=slh21*sdll5*slh23';
d7=slh21*sdll6*slh23';
d8=slh21*sdll7*slh23';
d9=slh21*sdll8*slh23';
d10=slh21*sdll9*slh23';



% o1=(d1-sll)./0.05;
  o1=(d1-slh)./0.005;
% o3=(d3-shl)./0.005;
% o4=(d4-shh)./0.005;
o2=(d2-slh)./0.005;
o3=(d3-slh)./0.005;
o4=(d4-slh)./0.005;
o5=(d5-slh)./0.005;
o6=(d6-slh)./0.005;
o7=(d7-slh)./0.005;
o8=(d8-slh)./0.005;
o9=(d9-slh)./0.005;
o10=(d10-slh)./0.005;




figure
imshow(wi);

figure
imshow(o1/255);
o1i=uint8(o1);
corr_original=corr2(o1i,wi)

figure
imshow(o2/255);
o2i=uint8(o2);
corr_rot=corr2(o2i,wi)

figure
imshow(o3/255);
o3i=uint8(o3);
corr_tran=corr2(o3i,wi)

figure
imshow(o4/255);
o4i=uint8(o4);
corr_sp=corr2(o4i,wi)

figure
imshow(o5/255);
o5i=uint8(o5);
corr_speckle=corr2(o5i,wi)

figure
imshow(o6/255);
o6i=uint8(o6);
corr_gaussian_noise=corr2(o6i,wi)

figure
imshow(o7/255);
o7i=uint8(o7);
corr_gaussian_filter=corr2(o7i,wi)

figure
imshow(o8/255);
o8i=uint8(o8);
corr_median_filter=corr2(o8i,wi)

figure
imshow(o9/255);
o9i=uint8(o9);
corr_center_crop=corr2(o9i,wi)

figure
imshow(o10/255);
o10i=uint8(o10);
corr_hist_eq=corr2(o10i,wi)

psnr1=psnr(ac,a)