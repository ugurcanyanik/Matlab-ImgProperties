clc;
close all;
clear;
workspace;
format long g;
format compact;
fontSize = 15;
%===============================================================================
% kullan�c�dan resmi alaca��m�z k�s�m
resmim = 'resim1.jpg'; % resmim ad�na inceleyece�imiz resmi ald�k
dosyam = fileparts(which('resim1.jpg')); % dosyan�n tam yolunu ald�k
dosyamFull = fullfile(dosyam, resmim);
%===============================================================================
% resmi okuyoruz
grayImage = imread(dosyamFull);
% resmin boyutlar�n� almal�y�z  
% numberOfColorBands = 1 olmal�
[rows, columns, renkKanali] = size(grayImage);
if renkKanali > 1
  % renkli oldu�u anlam�nda
  % sadece ye�il kanal� alarak griye d�nd�rd�k
  grayImage = grayImage(:, :, 2); % ye�il kanal� ald�k
end
% burada da resmi g�steriyoruz
subplot(3, 2, 1);
imshow(grayImage, []);
caption = sprintf('Original Grayscale Image, %s', resmim);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
subplot(3, 2, 2);
f = abs(fft2(grayImage));
shiftedf = fftshift(f);
imshow(log(shiftedf), []);
title('FFT2', 'FontSize', fontSize, 'Interpreter', 'None');
[rows, columns] = size(shiftedf);
radialProfile = zeros(1, ceil(sqrt(rows^2+columns^2)));
count = zeros(1, ceil(sqrt(rows^2+columns^2)));
midRow = rows/2 + 1;
midCol = columns/2 + 1;
for col = 1 : columns
  for row = 1 : rows
    radius = round(sqrt((row - midRow)^2 + (col - midCol)^2));
    if radius == 0
      continue;
    end
    radialProfile(radius) = radialProfile(radius) + shiftedf(row, col);
    count(radius) = count(radius) + 1;
  end
end

%ekrana yazd�raca��m�z k�s�m
radialProfile = radialProfile ./ count;
subplot(3, 2, 3);
plot(radialProfile, 'b-', 'LineWidth', 1);
grid on;
xlabel('yar��ap', 'FontSize', 20);
ylabel('g�� sinyali', 'FontSize', 20);

subplot(3, 2, 4);
%entropi de�eri
I = imread('resim1.jpg');
bar([entropy(I)])
xlabel(['Entropi de�eri = ', num2str(entropy(I))], 'FontSize', 20);

subplot(3, 2, 5);
bar([mean(resmim(:))])
xlabel(['resmin ort de�eri = ', num2str(mean(resmim(:)))], 'FontSize', 20);
