clc;
close all;
clear;

image = imread('resim1.jpg'); 
figure;
subplot(1, 2, 1);
bar([min(image(:))]);
xlabel(['resmin min de�eri = ', num2str(min(image(:)))], 'FontSize', 20);
subplot(1, 2, 2);
bar([max(image(:))]);
xlabel(['resmin max de�eri = ', num2str(max(image(:)))], 'FontSize', 20);