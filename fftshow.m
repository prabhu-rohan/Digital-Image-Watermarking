function [] = fftshow(f)
id=log(1+abs(f));
fm=max(id(:));
figure
imshow(im2uint8(id/fm));
end

