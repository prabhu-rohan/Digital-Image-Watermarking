clc;
clear all;
close all;
a=imread('C:\Users\Rohan Prabhu\Downloads\lenna.jpg');
wi=imread('cameraman.tif');
w=double(wi);
[ll lh hl hh]=dwt2(a,'haar');
[ull sll vll]=svd(ll);
[ulh slh vlh]=svd(lh);
[uhl shl vhl]=svd(hl);
 sll2=sll+0.05*w;
 slh2=slh+0.005*w;
 shl2=shl+0.005*w;
[sll21 sll22 sll23]=svd(sll2);
[slh21 slh22 slh23]=svd(slh2);
[shl21 shl22 shl23]=svd(shl2);

imgll=ull*sll22*vll';
imglh=ulh*slh22*vlh';
imghl=uhl*shl22*vhl';
imghh=hh;
sz=size(a);
imgaw=idwt2(imgll,imglh,imglh,imghh,'haar',sz);
figure
imshow(imgaw/255);
figure
imshow(a);


%decrypt
[lld lhd hld hhd]=dwt2(imgaw,'haar');
[llud llsd llvd]=svd(ll);
[lhud lhsd lhvd]=svd(lh);
[hlud hlsd hlvd]=svd(hl);

ill=sll21*llsd*sll23';
ilh=slh21*lhsd*slh23';
ihl=slh21*hlsd*shl23';
wll=(ill-sll)./0.05;
wlh=(ilh-slh)./0.005;
whl=(ihl-shl)./0.005;
figure
imshow(wll/255);
figure
imshow(wlh/255);
figure
imshow(whl/255);

