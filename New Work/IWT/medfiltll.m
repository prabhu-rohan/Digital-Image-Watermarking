clc;
clear all;
close all;
a=imread('C:\Users\Rohan Prabhu\Downloads\lenna.jpg');
ad=double(a);
wirgb=imread('C:\Users\Rohan Prabhu\Downloads\logo.jpg');
wi=rgb2gray(wirgb);
w=double(wi);
liftscheme = liftwave('haar','int2int');
[ll lh hl hh]=lwt2(ad,liftscheme);
% ll=blkproc(ll,[8 8],@dct2);
[ull sll vll]=svd(ll);
sll2=sll+0.05*w;
% [sll21 sll22 sll23]=svd(sll2);
imgll=ull*sll22*vll';
sz=size(a);
% imgll=blkproc(imgll,[8 8],@idct2);
imgaw=ilwt2(imgll,lh,hl,hh,liftscheme);

figure
imshow(a);
figure
imshow([ll/255 lh/255;hl/255 hh/255]);
ac=uint8(imgaw);
figure
imshow(ac);
%de-watermarking
%i/p=imgaw,sll,slh,shl,shh,sll21,sll23,slh21,slh23,shl21,shl23,slh21,slh23,shh21,shh23



% nac_rot=imrotate(ac,-270,'bilinear','crop');
% figure 
% imshow(nac_rot);
% 
% nac_tran=imtranslate(ac,[10,25]);
% figure 
% imshow(nac_tran);

%medfilt
nac_1(:,:,1)=medfilt2(ac,[2,2]);
nac_1(:,:,2)=medfilt2(ac,[3,3]);
nac_1(:,:,3)=medfilt2(ac,[5,5]);
nac_1(:,:,4)=medfilt2(ac,[7,7]);
nac_1(:,:,5)=medfilt2(ac,[9,9]);
nac_1(:,:,6)=medfilt2(ac,[11,11]);
nac_1(:,:,7)=medfilt2(ac,[13,13]);
%salt and pepper
nac_1(:,:,8)=imnoise(ac,'salt & pepper',0.5);
nac_1(:,:,9)=imnoise(ac,'salt & pepper',0.3);
nac_1(:,:,10)=imnoise(ac,'salt & pepper',0.1);
nac_1(:,:,11)=imnoise(ac,'salt & pepper',0.05);
nac_1(:,:,12)=imnoise(ac,'salt & pepper',0.01);
nac_1(:,:,13)=imnoise(ac,'salt & pepper',0.005);
%speckle
nac_1(:,:,14)=imnoise(ac,'speckle',0.5);
nac_1(:,:,15)=imnoise(ac,'speckle',0.3);
nac_1(:,:,16)=imnoise(ac,'speckle',0.1);
nac_1(:,:,17)=imnoise(ac,'speckle',0.05);
nac_1(:,:,18)=imnoise(ac,'speckle',0.01);
nac_1(:,:,19)=imnoise(ac,'speckle',0.005);
%gaussian noise
nac_1(:,:,20)=imnoise(ac,'gaussian',0.5);
nac_1(:,:,21)=imnoise(ac,'gaussian',0.3);
nac_1(:,:,22)=imnoise(ac,'gaussian',0.1);
nac_1(:,:,23)=imnoise(ac,'gaussian',0.05);
nac_1(:,:,24)=imnoise(ac,'gaussian',0.01);
nac_1(:,:,25)=imnoise(ac,'gaussian',0.005);
%gamma correction
nac_1(:,:,26)=imadjust(ac,[],[],1);
nac_1(:,:,27)=imadjust(ac,[],[],0.8);
nac_1(:,:,28)=imadjust(ac,[],[],0.6);
nac_1(:,:,29)=imadjust(ac,[],[],0.4);
nac_1(:,:,30)=imadjust(ac,[],[],0.3);
nac_1(:,:,31)=imadjust(ac,[],[],0.2);
nac_1(:,:,32)=imadjust(ac,[],[],0.1);

for i=1:size(nac_1,3)
    [dll1 dlh1 dhl1 dhh1]=lwt2(double(nac_1(:,:,i)),liftscheme);
%     dll1=blkproc(dll1,[8 8],@dct2);
    [udll1 sdll1 vdll1]=svd(dll1);
    d2=sll21*sdll1*sll23';
    o2=(d2-sll)./0.05;
    o2i=uint8(o2);
    % imshow(o1/255);
    med(i)=corr2(o2i,w);
end

psnr1=psnr(ac,a)
