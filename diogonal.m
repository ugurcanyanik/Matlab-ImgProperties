clc;
close all;
clear;
% diogonal kesit çapraz tanýmlanmasý gereklidir ve x ekseni için yapýlmýþ
% bir koddur. program çalýþtýktan sonra tüm pikseller için gerekli çapraz x
% eksenleri bulunur. daha sonra çapraz teknik için bakacaðýnýz iki aralýðý
% seçiniz. sonrasýnda figür ortaya çýkýp size grafikleri sunacak.
A=imread('resim1.jpg')
figure(1);
imshow(A)
p=ginput(2)
figure(1);hold all; 
plot(p(:,1),p(:,2),'ro')
N=max(abs(p(1,1)-p(2,1)),abs(p(2,1)-p(2,2)))
Lx=linspace(p(1,1),p(2,1),N)
Ly=linspace(p(1,2),p(2,2),N)
figure(1);hold all; plot(Lx,Ly,'r')
Lx2=uint64(floor(Lx))
Ly2=uint64(floor(Ly))
CS1_R=A(sub2ind(size(A(:,:,1)),Lx2,Ly2))
CS1_G=A(sub2ind(size(A(:,:,2)),Lx2,Ly2))
CS1_B=A(sub2ind(size(A(:,:,3)),Lx2,Ly2))
nCS1=[1:length(CS1_R)]
figure(3);
subplot(3,1,1);plot(nCS1,CS1_R,'r')
subplot(3,1,2);plot(nCS1,CS1_G,'g')
subplot(3,1,3);plot(nCS1,CS1_B,'b')