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
  [uhl shl vhl]=svd(hl);
% [uhh shh vhh]=svd(hh);

% sll2=sll+0.05*w;
% slh2=slh+0.005*w;
  shl2=shl+0.005*w;
% shh2=shh+0.005*w;

% [sll21 sll22 sll23]=svd(sll2);
% [slh21 slh22 slh23]=svd(slh2);
  [shl21 shl22 shl23]=svd(shl2);
% [shh21 shh22 shh23]=svd(shh2);

% imgll=ull*sll22*vll';
% imglh=ulh*slh22*vlh';
  imghl=uhl*shl22*vhl';
% imghh=uhh*shh22*vhh';

sz=size(a);
imgaw=idwt2(ll,lh,imghl,hh,'haar',sz);

figure
imshow(a);
figure
imshow([ll/255 lh/255;hl/255 hh/255]);
ac=uint8(imgaw);
figure
imshow(ac);

%de-watermarking
%i/p=imgaw,sll,slh,shl,shh,sll21,sll23,slh21,slh23,shl21,shl23,slh21,slh23,shh21,shh23

nac_jpg=imread('C:\Users\Rohan Prabhu\Desktop\Project\Project Data\Compression\HL\5.jpg');
figure 
imshow(nac_jpg);

nac_jpg2=imread('C:\Users\Rohan Prabhu\Desktop\Project\Project Data\Compression\HL\10.jpg');
figure 
imshow(nac_jpg2);


nac_jpg3=imread('C:\Users\Rohan Prabhu\Desktop\Project\Project Data\Compression\HL\20.jpg');
figure 
imshow(nac_jpg3);

nac_jpg4=imread('C:\Users\Rohan Prabhu\Desktop\Project\Project Data\Compression\HL\25.jpg');
figure 
imshow(nac_jpg4);

nac_jpg5=imread('C:\Users\Rohan Prabhu\Desktop\Project\Project Data\Compression\HL\30.jpg');
figure 
imshow(nac_jpg5);

nac_jpg6=imread('C:\Users\Rohan Prabhu\Desktop\Project\Project Data\Compression\HL\40.jpg');
figure 
imshow(nac_jpg6);

nac_jpg7=imread('C:\Users\Rohan Prabhu\Desktop\Project\Project Data\Compression\HL\50.jpg');
figure 
imshow(nac_jpg7);

nac_jpg8=imread('C:\Users\Rohan Prabhu\Desktop\Project\Project Data\Compression\HL\70.jpg');
figure 
imshow(nac_jpg8);


[dll dlh dhl dhh]=dwt2(imgaw,'haar');

[dll1 dlh1 dhl1 dhh1]=dwt2(nac_jpg,'haar');
 [dll2 dlh2 dhl2 dhh2]=dwt2(nac_jpg2,'haar');
 [dll3 dlh3 dhl3 dhh3]=dwt2(nac_jpg3,'haar');
 [dll4 dlh4 dhl4 dhh4]=dwt2(nac_jpg4,'haar');
 [dll5 dlh5 dhl5 dhh5]=dwt2(nac_jpg5,'haar');
 [dll6 dlh6 dhl6 dhh6]=dwt2(nac_jpg6,'haar');
 [dll7 dlh7 dhl7 dhh7]=dwt2(nac_jpg7,'haar');
 [dll8 dlh8 dhl8 dhh8]=dwt2(nac_jpg8,'haar');
%  [dll7 dlh7 dhl7 dhh7]=dwt2(nac_rot7,'haar');
% [dll8 dlh8 dhl8 dhh8]=dwt2(nac_median_filter,'haar');
% [dll9 dlh9 dhl9 dhh9]=dwt2(nac_hist_eq,'haar');

[udhl sdhl vdhl]=svd(dhl);

[udll1 sdll1 vdll1]=svd(dhl1);
[udll2 sdll2 vdll2]=svd(dhl2);
[udll3 sdll3 vdll3]=svd(dhl3);
[udll4 sdll4 vdll4]=svd(dhl4);
[udll5 sdll5 vdll5]=svd(dhl5);
[udll6 sdll6 vdll6]=svd(dhl6);
[udll7 sdll7 vdll7]=svd(dhl7);
[udll8 sdll8 vdll8]=svd(dhl8);
% [udll9 sdll9 vdll9]=svd(dhl9);


% d1=sll21*sdll*sll23';
% d2=slh21*sdlh*slh23';
  d1=shl21*sdhl*shl23';
% d4=shh21*sdhh*shh23';

d2=shl21*sdll1*shl23';
d3=shl21*sdll2*shl23';
d4=shl21*sdll3*shl23';
d5=shl21*sdll4*shl23';
d6=shl21*sdll5*shl23';
d7=shl21*sdll6*shl23';
d8=shl21*sdll7*shl23';
d9=shl21*sdll8*shl23';
% d10=shl21*sdll9*shl23';


% o1=(d1-sll)./0.05;
% o2=(d2-slh)./0.005;
  o1=(d1-shl)./0.005;
% o4=(d4-shh)./0.005;


o2=(d2-shl)./0.005;
o3=(d3-shl)./0.005;
o4=(d4-shl)./0.005;
o5=(d5-shl)./0.005;
o6=(d6-shl)./0.005;
o7=(d7-shl)./0.005;
o8=(d8-shl)./0.005;
o9=(d9-shl)./0.005;
% o10=(d10-shl)./0.005;



figure
imshow(wi);

figure
imshow(o1/255);
o1i=uint8(o1);
corr_original=corr2(o1i,wi)

figure
imshow(o2/255);
o2i=uint8(o2);
corr_sp=corr2(o2i,wi)


figure
imshow(o3/255);
o3i=uint8(o3);
corr_sp1=corr2(o3i,wi)

figure
imshow(o4/255);
o4i=uint8(o4);
corr_sp2=corr2(o4i,wi)

figure
imshow(o5/255);
o5i=uint8(o5);
corr_sp3=corr2(o5i,wi)

figure
imshow(o6/255);
o6i=uint8(o6);
corr_sp4=corr2(o6i,wi)

figure
imshow(o7/255);
o7i=uint8(o7);
corr_sp5=corr2(o7i,wi)

figure
imshow(o8/255);
o8i=uint8(o8);
corr_sp6=corr2(o8i,wi)

figure
imshow(o9/255);
o9i=uint8(o9);
corr_sp7=corr2(o9i,wi)

psnr1=psnr(ac,a)