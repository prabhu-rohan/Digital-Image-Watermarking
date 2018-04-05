key=15;
a=imread('C:\Users\Rohan Prabhu\Downloads\lenna.jpg');
wirgb=imread('C:\Users\Rohan Prabhu\Downloads\logo.jpg');
wi=rgb2gray(wirgb);
w=double(wi);
[ll lh hl hh]=dwt2(a,'haar');
[ull sll vll]=svd(ll);
sll2=sll+0.05*w;
[sll21 sll22 sll23]=svd(sll2);
imgll=ull*sll22*vll';
sz=size(a);
imgaw=idwt2(imgll,lh,hl,hh,'haar',sz);


%signature generation
[ll lh hl hh]=dwt2(imgaw,'haar');
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

y = bin2dec(sigc);
signature= decimalToBinaryVector(y);

% 1. Using Haar wavelet, further decompose LL band to the 4th level.
[LL_1, HL_1, LH_1, HH_1] = dwt2(ll, 'haar');    % 1st step DWT
[LL_2, HL_2, LH_2, HH_2] = dwt2(LL_1, 'haar');  % 2nd step DWT
[LL_3, HL_3, LH_3, HH_3] = dwt2(LL_2, 'haar');  % 3rd step DWT
[LL_4, HL_4, LH_4, HH_4] = dwt2(LL_3, 'haar');  % 4rth step DWT

    
    % Plot 4-th step decomposition
    figure;
    imshow([LL_4/255,HL_4/255;LH_4/255,HH_4/255]);
    title('4-th step DWT decomposition');
    


% 1. choose all in total 512 coefficients from LL_4 & HH_4
% reshape them to row vectors of size 1x256
LL_4 = reshape(LL_4, 1, length(LL_4)^2);
HH_4 = reshape(HH_4, 1, length(HH_4)^2);

% concatenate the above row vectors into a larger row vector of size 1x512
combined_LL4_and_HH4_coef = [LL_4 HH_4];

% keep record of the index position of negatives to put back the sign in
% inverse process
negative_idxs = combined_LL4_and_HH4_coef(logical(combined_LL4_and_HH4_coef)) < 0;

% keep only the positive integer parts
% combined_LL4_and_HH4_coeff_posint = round( abs( combined_LL4_and_HH4_coef ) );

% separate the integer from the decimal fraction
combined_LL4_and_HH4_coeff_pos = abs(combined_LL4_and_HH4_coef);
integer_part = fix(combined_LL4_and_HH4_coeff_pos);
fraction_part = abs(combined_LL4_and_HH4_coeff_pos - integer_part);

% Convert the integer part into the binary code of L=16 bits.
binary_coefficients = {};
for p = 1:length(integer_part)
    % binary_coefficients{p} = bitget( uint16( integer_part(p) ), 16:-1:1 );
    binary_coefficients{p} = decimalToBinaryVector(integer_part(p), 16);
end

% 2. Replace the n-th bit (10th bit) position of the coefficient with
% signature bit
for m = 1:length(signature)
    for n = 1:16
        if (n == 10)
            signature(m)
            binary_coefficients{1, m}(n) = signature(m);
        end
    end
end
% and then convert the binary code to its decimal representation
bin2decimal = zeros(1, length(binary_coefficients));
for x = 1:length(binary_coefficients)
    bin2decimal(x) = binaryVectorToDecimal(double(binary_coefficients{1, x}));
end

% reconstruct orignal array from integer and decimal fraction parts
% cmb_coef = integer_part + fraction_part;
bin2decimal = bin2decimal + fraction_part;

% put back the negative signs
bin2decimal(find(negative_idxs == 1)) = -bin2decimal(find(negative_idxs == 1));

% Clear workspace
clear('LL_1', 'LL_2', 'LL_3', 'LL_4', 'HH_4', 'combined_LL4_and_HH4_coef',...
    'negative_idxs', 'combined_LL4_and_HH4_coeff_pos', 'integer_part',...
    'fraction_part', 'binary_coefficients', 'signature');

% reshape the modified LL_4 & HH_4 sub-bands to their original size 16x16
% each
LL_4_modified = bin2decimal(1:256);
HH_4_modified = bin2decimal(257:end);
LL_4_modified = reshape(LL_4_modified, 16, 16);
HH_4_modified = reshape(HH_4_modified, 16, 16);

% Clear workspace
clear('bin2decimal');

% 3. Apply the inverse DWT with modified LL4 and HH4 band coefficients.
LL_3_inv = idwt2(LL_4_modified, HL_4, LH_4, HH_4_modified, 'haar');
LL_2_inv = idwt2(LL_3_inv, HL_3, LH_3, HH_3, 'haar');
LL_1_inv = idwt2(LL_2_inv, HL_2, LH_2, HH_2, 'haar');
LL_inv   = idwt2(LL_1_inv, HL_1, LH_1, HH_1, 'haar');

img_after_w_sig=idwt2(LL_inv,lh,hl,hh,'haar',sz);
img_after_w_sig_i=uint8(img_after_w_sig);
imshow(img_after_w_sig_i);

% attacks
% att1=medfilt2(img_after_w_sig_i,[3 3]);
% att2=wiener2(img_after_w_sig_i,[3 3]);
%  att1=imnoise(img_after_w_sig_i,'salt & pepper',0.05);
%  att2=imnoise(img_after_w_sig_i,'speckle',0.05);
 att1=imadjust(img_after_w_sig_i,[],[],0.7);
% att2=imnoise(img_after_w_sig_i,'gaussian',0.05);
% att1=imrotate(img_after_w_sig_i,180,'bilinear','crop');
% att2=imresize(img_after_w_sig_i,0.5);
% att2=imresize(att2,2);
% mkdir('New Folder');
% imwrite(img_after_w_sig_i,'New Folder/n1.jpg','Quality',20);
% att1=imread('New Folder/n1.jpg');
