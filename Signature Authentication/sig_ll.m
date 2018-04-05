clc
clear all
close all
key=15;
a=imread('C:\Users\Rohan Prabhu\Downloads\lenna.jpg');
wirgb=imread('C:\Users\Rohan Prabhu\Downloads\logo.jpg');
wi=rgb2gray(wirgb);
w=double(wi);
liftscheme = liftwave('haar','int2int');
[ll lh hl hh]=lwt2(double(a),liftscheme);
[ull sll vll]=svd(ll);
sll2=sll+0.05*w;
[sll21 sll22 sll23]=svd(sll2);
imgll=ull*sll22*vll';
sz=size(a);
imgaw=ilwt2(imgll,lh,hl,hh,liftscheme);
imgawi=uint8(imgaw);
figure
imshow(imgawi);


%Signature Generation
k=sum(sll21);
l=sum(sll23);
ustr='';
vstr='';
for i=1:length(k)
    kstr=num2str(k(i));
    ustr=strcat(ustr,kstr);
end
for i=1:length(l)
    temp=num2str(l(i));
    vstr=strcat(vstr,temp);
end




string = ustr;
sha1hasher = System.Security.Cryptography.SHA1Managed;
sha1= uint8(sha1hasher.ComputeHash(uint8(string)));
b1=sha1(1);
b2=sha1(2);

string = vstr; 
sha1hasher = System.Security.Cryptography.SHA1Managed;
sha2= uint8(sha1hasher.ComputeHash(uint8(string)));
b3=sha2(1);
b4=sha2(2);

sig=bitxor(b1,b3);
sig_final=bitxor(sig,key);
sigc=dec2bin(sig_final,8);

%Signature Embedding
[ll1 lh1 hl1 hh1]=dwt2(imgawi,'haar');
cnt=1;
for i=1:8:256
    for j=1:8:256
        c(:,:,cnt)=ll1(i:i+7,j:j+7);
        cnt=cnt+1;
    end
end
tempo=1024
   for j=1:8
       if(sigc(j)=='0')
            temp=c(:,:,tempo);
            [tempu temps tempv]=svd(temp);
            tempu(2,1)=floor(tempu(2,1)*10);
            tempu(2,1)
            if((sigc(j)=='1' & mod(tempu(2,1),2)==0) | (sigc(j))=='0' & mod(tempu(2,1),2)==1) 
            tempu(2,1)=tempu(2,1)+1;
            tempu(2,1)=tempu(2,1)/10;
            end
            tempu(2,1)
            temp=tempu*temps*tempv';
            c(:,:,tempo)=temp;
            tempo=tempo-42;
       else
            temp=c(:,:,tempo);
            [tempu temps tempv]=svd(temp);
            tempu(2,1)=floor(tempu(2,1)*10);
            tempu(2,1)
           if((sigc(j)=='1' & mod(tempu(2,1),2)==0) | (sigc(j))=='0' & mod(tempu(2,1),2)==1)
            tempu(2,1)=tempu(2,1)+1;
            tempu(2,1)=tempu(2,1)/10;
            end
            tempu(2,1)
            temp=tempu*temps*tempv';
            c(:,:,tempo)=temp;
            tempo=tempo-69;
       end
   end
ll2=zeros(256,256);

i=1;j=1; 
for k=1:1024
    ll2(i:i+7,j:j+7)=c(:,:,k);
    j=j+8;
    if(j==257)
        j=1;
        i=i+8;
    end
end

    

figure
imshow(ll2/255);
sz=size(a);
sz
imgac=idwt2(ll2,lh1,hl1,hh1,'haar',sz);
figure
imshow(imgac/255);



%Reciever Side
bit_extracted='';
imgrx=imgac;
[llrx lhrx hlrx hhrx]=dwt2(imgac,'haar');

for i=1:8:64
    temp=llrx(1:8,i:i+7);
    [tempu temps tempv]=svd(temp);
    tempo=floor(tempu(2,1)/10);
    tempu(2,1)
    if(mod(tempo,2)==0)
        bit_extracted=strcat(bit_extracted,'1');
    else
        bit_extracted=strcat(bit_extracted,'0');
    end
    
end
bit_extracted=sigc


    


