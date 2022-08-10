clear
close all
clc
warning('off', 'Images:initSize:adjustingMag');
% Imagem Original


I_RGB = imread('input1.JPG');
I = rgb2gray(I_RGB);
figure;
imshow(I_RGB);
set(gcf,'name','Imagem Original');
I = im2double(I);

%Binarização Direta (Insuficiente)
bw = ~imbinarize(I, graythresh(I));
figure;
imshowpair(I, bw, 'montage');
set(gcf,'name','Imagem Grayscale e Binarização');


% Pré-Processamento
%%Metodo 1
Ic = imcomplement(I);
bw = imbinarize(Ic,graythresh(Ic));

%%Metodo 2
bw2 = ~imbinarize(I, adaptthresh(I));

%%Metodo 3
Ih = imadjust(I);
bw3 = ~imbinarize(Ih);

%%Metodo 4 
I_th=imtophat(I,strel('disk',40));
%Aumento de contraste I
I_ad = imadjust(I_th);
bw4 = ~imbinarize(I_ad);

%%Metodo 5
%Aumento de contraste II (CLAHE)
I_eq = adapthisteq(I);
bw5 = ~imbinarize(I_eq);

%%Metodo 6 
H = fspecial('average',7);
I1 = imfilter(I,H);
H = -1*[1 1 1; 1 -8 1; 1 1 1];
I2 = imfilter(I,H);
I_con = imsharpen(I);
bw6 = ~imbinarize(I_con);

figure
subplot(2,3,1);
imshow(bw);
title("Complemento");
subplot(2,3,2);
imshow(bw2);
title("Adaptativo");
subplot(2,3,3);
imshow(bw3);
title("ImAdjust");
subplot(2,3,4);
imshow(bw4);
title("Top Hat + ImAdjust");
subplot(2,3,5);
imshow(bw5);
title("HistEq Adapativo");
subplot(2,3,6);
imshow(bw6);
title("Unsharping Mask");
suptitle("Binarizações");


% Eliminação de Ruídos
BW = bwareaopen(bw6,40);
BW2 = ~imopen(~BW,strel('square',3));
imshow(BW2);
set(gcf,'name','Eliminação de Ruídos');

% Watershed 
%Metodo 1
D = bwdist(BW2);
D1 = - D;
L = watershed(D1);
L(BW2) = 0;
L1 = label2rgb(L,'jet',[.8 .8 .8]);

%Metodo 2
D = bwdist(BW2);
D(BW2) = Inf;
D1 = imcomplement(D);
L = watershed(D1);
L2 = label2rgb(L,'jet','w');
figure
imshowpair(L1, L2, 'montage');
title("Comparação Metodos de Watershed");


stats = regionprops('table',L,'Area',...
    'Perimeter','Eccentricity');

%Retirada do Fundo e de Linha Vertical
stats(1,:) = [];
stats(218,:) = [];

N = size(stats,1);
Ab = mean(stats.Area);
dA = std(stats.Area);
Pb = mean(stats.Perimeter);
dP = std(stats.Perimeter);
Circ = (4 * pi* stats.Area) ./ stats.Perimeter  .^ 2;
Cb = mean(Circ);
dC = std(Circ);
Eb = mean(stats.Eccentricity);
dE = std(stats.Eccentricity);
max(Circ);
min(Circ);

histogram(stats.Area,13)
title("Distribuição Área");
