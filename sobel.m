clc;
close all;
clear;

A=imread('resim1.jpg');
figure;
subplot(2,2,1);
imshow(A);
title('orijinal resim');
B=rgb2gray(A);
C=double(B);
for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));

        B(i,j)=sqrt(Gx.^2+Gy.^2);
    end
end
subplot(2,2,2);
imshow(B);
title('sobel filtrelenmiþ resim');
Thresh=100;
B=max(B,Thresh);
B(B==round(Thresh))=0;

B=uint8(B);
subplot(2,2,3:4);
imshow(~B);
title('kenar algýlanan resim');
