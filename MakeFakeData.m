close all;
clear;

D = 1024;
I = zeros(D);

vX = linspace(15,58,1024);
vY = linspace(38,-9,1024);

x = 400;
y = 600;

SE = strel('Disk', 35);

I(x, y) = 1;
I       = imdilate(I, SE);

date  = '20171213_';
vTime = (0 : (12*4)) * 15 / 60;

for ii = 0 : 23
    for jj = 0 : 15 : 45
        

figure; imagesc(I);


