clc; clear; close all;
pkg load image;


% Imagen original
A = imread("image_test3.png");
subplot(2,2,1);
imshow(A)
title("Imagen original")

% Histograma imagen original
subplot(2,2,2);
imhist(A);
title("Histograma imagen original")

% Imagen modificada
B = load("-ascii","image.txt");
B = reshape(B,[400,400]);
B = uint8(B);
B = B';
subplot(2,2,3);
imshow(B);
title("Imagen modificada")

% Histograma imagen modificada
subplot(2,2,4);
imhist(B)
title("Histograma imagen modificada")