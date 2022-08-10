clear
close all
clc
warning('off', 'Images:initSize:adjustingMag');

%Binarização da Imagem
img_original = rgb2gray(imread('img_cells.jpg'));
imshow(img_original);
set(gcf,'name','Imagem Original');
level = graythresh(img_original);
bin_img = imbinarize(img_original,level);
figure
imshow(bin_img);
set(gcf,'name','Imagem Binarizada');

%Tratamento das desconexões
bw = bwareaopen(bin_img, 100);

%Preenchimento de Buracos
bw2 = imfill(~bw,'holes');
figure
imshow(bw2);
title("Imagem Pré-Processada");

%Função de Distâncias
D = -bwdist(~bw2);
D(~bw2) = -Inf;
figure
imshow(imcomplement(D), [])
title("Complemento da Função de Distâncias");

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