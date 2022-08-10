clear
close all
clc

%Binarização da Imagem
img_original = imread('cookies.tif');
imshow(img_original);
set(gcf,'name','Imagem Original');
level = graythresh(img_original);
bin_img = imbinarize(img_original,level);

%Abertura e Dilatação
SE = strel('disk',56); 
img_opened = imopen(bin_img,SE);
SE = strel('disk',9);
img_dilated = imdilate(img_opened,SE);

%Recuperação da forma original do cookie inteiro
%Aplica-se Máscara Binária
img_processed = img_dilated.*bin_img;

%Geração da imagem em níveis de cinza
img_processed_grayscale = double(img_original).*...
double(img_processed); %Casting para poder multiplicar
figure;
imshow(uint8(img_processed_grayscale));
set(gcf,'name','Imagem com um Cookie (Grayscale)');
