clc;
close all;
clear;
workspace;
format long g;
format compact;
fontSize = 15;
%===============================================================================
% kullanýcýdan resmi alacaðýmýz kýsým
resmim = 'resim1.jpg'; % resmim adýna inceleyeceðimiz resmi aldýk
dosyam = fileparts(which('resim1.jpg')); % dosyanýn tam yolunu aldýk
dosyamFull = fullfile(dosyam, resmim);
%===============================================================================
% resmi okuyoruz
grayImage = imread(dosyamFull);
% resmin boyutlarýný almalýyýz  
% numberOfColorBands = 1 olmalý
[rows, columns, renkKanali] = size(grayImage);
if renkKanali > 1
  % renkli olduðu anlamýnda
  % sadece yeþil kanalý alarak griye döndürdük
  grayImage = grayImage(:, :, 2); % yeþil kanalý aldýk
end
% burada da resmi gösteriyoruz
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

%ekrana yazdýracaðýmýz kýsým
radialProfile = radialProfile ./ count;
subplot(3, 2, 3);
plot(radialProfile, 'b-', 'LineWidth', 1);
grid on;
xlabel('yarýçap', 'FontSize', 20);
ylabel('güç sinyali', 'FontSize', 20);

subplot(3, 2, 4);
%entropi deðeri
I = imread('resim1.jpg');
bar([entropy(I)])
xlabel(['Entropi deðeri = ', num2str(entropy(I))], 'FontSize', 20);

subplot(3, 2, 5);
bar([mean(resmim(:))])
xlabel(['resmin ort deðeri = ', num2str(mean(resmim(:)))], 'FontSize', 20);
