clear
close all
clc
warning('off', 'Images:initSize:adjustingMag');

%Binariza��o da Imagem
img_original = rgb2gray(imread('img_cells.jpg'));
imshow(img_original);
set(gcf,'name','Imagem Original');
level = graythresh(img_original);
bin_img = imbinarize(img_original,level);
figure
imshow(bin_img);
set(gcf,'name','Imagem Binarizada');

%Tratamento das desconex�es
bw = bwareaopen(bin_img, 100);

%Preenchimento de Buracos
bw2 = imfill(~bw,'holes');
figure
imshow(bw2);
title("Imagem Pr�-Processada");

%Fun��o de Dist�ncias
D = -bwdist(~bw2);
D(~bw2) = -Inf;
figure
imshow(imcomplement(D), [])
title("Complemento da Fun��o de Dist�ncias");

%Transformada Watershed
L = watershed(D);
figure;
imshow(label2rgb(L,'jet',[0.9 0.9 0.9]));
title('Watershed');


%%% Metodo II (Inferior)
% img_original = rgb2gray(imread('img_cells.jpg'));
% level = graythresh(img_original);
% bin_img = imbinarize(img_original,level);
% bw = bwareaopen(bin_img, 100);
% bw2 = imfill(~bw,'holes');
% D = bwdist(~bw2);
% L = watershed(-D);
% L(~bw2) = 0;
% imshow(label2rgb(L,'jet',[0.7 0.7 0.7]));
% title('Watershed');