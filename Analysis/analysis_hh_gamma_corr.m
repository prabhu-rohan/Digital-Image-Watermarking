clc;
clear all;
close all;
a=imread('C:\Users\Rohan Prabhu\Downloads\lenna.jpg');
wirgb=imread('C:\Users\Rohan Prabhu\Downloads\logo.jpg');
wi=rgb2gray(wirgb);
w=double(wi);
[ll lh hl hh]=dwt2(a,'haar');
% [ull sll vll]=svd(ll);
% [ulh slh vlh]=svd(lh);
% [uhl shl vhl]=svd(hl);
  [uhh shh vhh]=svd(hh);

% sll2=sll+0.05*w;
% slh2=slh+0.005*w;
% shl2=shl+0.005*w;
  shh2=shh+0.005*w;

% [sll21 sll22 sll23]=svd(sll2);
% [slh21 slh22 slh23]=svd(slh2);
% [shl21 shl22 shl23]=svd(shl2);  
  [shh21 shh22 shh23]=svd(shh2);

% imgll=ull*sll22*vll';
% imglh=ulh*slh22*vlh';
% imghl=uhl*shl22*vhl';
  imghh=uhh*shh22*vhh';

sz=size(a);
imgaw=idwt2(ll,lh,hl,imghh,'haar',sz);

figure
imshow(a);
figure
imshow([ll/255 lh/255;hl/255 hh/255]);
ac=uint8(imgaw);
figure
imshow(ac);
%de-watermarking
%i/p=imgaw,sll,slh,shl,shh,sll21,sll23,slh21,slh23,shl21,shl23,slh21,slh23,shh21,shh23

nac_22=imadjust(ac,[],[],1);
figure 
imshow(nac_22);

nac_33=imadjust(ac,[],[],0.8);
figure 
imshow(nac_33);

nac_55=imadjust(ac,[],[],0.6);
figure 
imshow(nac_55);

nac_77=imadjust(ac,[],[],0.4);
figure 
imshow(nac_77);

nac_99=imadjust(ac,[],[],0.3);
figure 
imshow(nac_99);

nac_1111=imadjust(ac,[],[],0.2);
figure 
imshow(nac_1111);

nac_1313=imadjust(ac,[],[],0.1);
figure 
imshow(nac_1313);



[dll dlh dhl dhh]=dwt2(imgaw,'haar');

[dll1 dlh1 dhl1 dhh1]=dwt2(nac_22,'haar');
[dll2 dlh2 dhl2 dhh2]=dwt2(nac_33,'haar');
[dll3 dlh3 dhl3 dhh3]=dwt2(nac_55,'haar');
[dll4 dlh4 dhl4 dhh4]=dwt2(nac_77,'haar');
[dll5 dlh5 dhl5 dhh5]=dwt2(nac_99,'haar');
[dll6 dlh6 dhl6 dhh6]=dwt2(nac_1111,'haar');
[dll7 dlh7 dhl7 dhh7]=dwt2(nac_1313,'haar');

% [udll sdll vdll]=svd(dll);
% [udlh sdlh vdlh]=svd(dlh);
% [udhl sdhl vdhl]=svd(dhl);
  [udhh sdhh vdhh]=svd(dhh);
  
  [udll1 sdll1 vdll1]=svd(dhh1);
[udll2 sdll2 vdll2]=svd(dhh2);
[udll3 sdll3 vdll3]=svd(dhh3);
[udll4 sdll4 vdll4]=svd(dhh4);
[udll5 sdll5 vdll5]=svd(dhh5);
[udll6 sdll6 vdll6]=svd(dhh6);
[udll7 sdll7 vdll7]=svd(dhh7);
% [udll8 sdll8 vdll8]=svd(dhh8);
% [udll9 sdll9 vdll9]=svd(dhh9);


% d1=sll21*sdll*sll23';
% d2=slh21*sdlh*slh23';
% d3=shl21*sdhl*shl23';
  d1=shh21*sdhh*shh23';
  
  d2=shh21*sdll1*shh23';
d3=shh21*sdll2*shh23';
d4=shh21*sdll3*shh23';
d5=shh21*sdll4*shh23';
d6=shh21*sdll5*shh23';
d7=shh21*sdll6*shh23';
d8=shh21*sdll7*shh23';
% d9=shh21*sdll8*shh23';
% d10=shh21*sdll9*shh23';

% o1=(d1-sll)./0.05;
% o2=(d2-slh)./0.005;
% o3=(d3-shl)./0.005;
  o1=(d1-shh)./0.005;
  
o2=(d2-shh)./0.005;
o3=(d3-shh)./0.005;
o4=(d4-shh)./0.005;
o5=(d5-shh)./0.005;
o6=(d6-shh)./0.005;
o7=(d7-shh)./0.005;
o8=(d8-shh)./0.005;
% o9=(d9-shh)./0.005;
% o10=(d10-shh)./0.005;

figure
imshow(wi);

figure
imshow(o1/255);
o1i=uint8(o1);
corr_original=corr2(o1i,wi)

figure
imshow(o2/255);
o2i=uint8(o2);
corr_22=corr2(o2i,wi)

figure
imshow(o3/255);
o3i=uint8(o3);
corr_33=corr2(o3i,wi)

figure
imshow(o4/255);
o4i=uint8(o4);
corr_55=corr2(o4i,wi)

figure
imshow(o5/255);
o5i=uint8(o5);
corr_77=corr2(o5i,wi)

figure
imshow(o6/255);
o6i=uint8(o6);
corr_99=corr2(o6i,wi)

figure
imshow(o7/255);
o7i=uint8(o7);
corr_1111=corr2(o7i,wi)

figure
imshow(o8/255);
o8i=uint8(o8);
corr_1313=corr2(o8i,wi)

% figure
% imshow(o8/255);
% o8i=uint8(o8);
% corr_rot7=corr2(o8i,wi)

% figure
% imshow(o1/255);
% o1i=uint8(o1);
% corr_original=corr2(o1i,wi)
% 
% figure
% imshow(o2/255);
% o2i=uint8(o2);
% corr_rot=corr2(o2i,wi)
% 
% figure
% imshow(o3/255);
% o3i=uint8(o3);
% corr_tran=corr2(o3i,wi)
% 
% figure
% imshow(o4/255);
% o4i=uint8(o4);
% corr_sp=corr2(o4i,wi)
% 
% figure
% imshow(o5/255);
% o5i=uint8(o5);
% corr_speckle=corr2(o5i,wi)
% 
% figure
% imshow(o6/255);
% o6i=uint8(o6);
% corr_gaussian_noise=corr2(o6i,wi)
% 
% figure
% imshow(o7/255);
% o7i=uint8(o7);
% corr_gaussian_filter=corr2(o7i,wi)
% 
% figure
% imshow(o8/255);
% o8i=uint8(o8);
% corr_median_filter=corr2(o8i,wi)
% 
% figure
% imshow(o9/255);
% o9i=uint8(o9);
% corr_center_crop=corr2(o9i,wi)
% 
% figure
% imshow(o10/255);
% o10i=uint8(o10);
% corr_hist_eq=corr2(o10i,wi)
% 

psnr1=psnr(ac,a)