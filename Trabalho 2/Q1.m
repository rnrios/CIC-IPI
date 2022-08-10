clear
close all
clc
warning('off', 'Images:initSize:adjustingMag');

%Binarização da Imagem
img_original = imread('morf_test.png');
imshow(img_original);
set(gcf,'name','Imagem Original');
level = graythresh(img_original);
bin_img = imbinarize(img_original,level);
figure
imshow(bin_img);
set(gcf,'name','Imagem Binarizada');


%%%Proposição do Gradiente Morfológico
img_original_float = im2double(imread('morf_test.png'));

%Definição dos Elementos Estruturantes
SE = strel('disk',2);
SE1 = strel('disk',1);

%Dilatação e Erosão
img_dilated = imdilate(img_original_float,SE);
img_eroded = imerode(img_original_float,SE1);

%Gradiente
grad = img_dilated - img_eroded;
figure;
imshow(grad, []);
set(gcf,'name','Gradiente Morfologico');

%Binarização da Imagem Gerada pelo Gradiente Morfológico
level = graythresh(grad);
bin_grad = imbinarize(grad,level);

%Inversão da Imagem
bin_grad = bin_grad <= 0;
figure;
imshow(bin_grad);
set(gcf,'name','Gradiente Morfologico Binarizado e Invertido');