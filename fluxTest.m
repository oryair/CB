clc;
clear all
close all hidden

CB = false;


if (CB)
    
    load('cb_exp');
    data(:,:,1) = cb1;
    data(:,:,2) = cb2;
    [M,N] = size(cb1);
    
else
    % create synthetic example
    M      = 300;
    N      = M;
    x1     = round(3*M/4);
    y1     = round(3*M/4);
    x2     = round(M/4);
    y2     = round(M/4);
    shift  = 5;
    data   = zeros(M,M,2);

    data(x1,y1,1)                 = 1;
    data(x1+shift,y1+shift,2)     = 1;
    data(x2,y2,1)                 = 1;

    se1               = strel('disk',30);
    se2               = strel('disk',40);
    data(:,:,1)       = imdilate(data(:,:,1),se1);
    temp              = zeros(M);
    temp(x2,y2,1)     = 1;  
    data(:,:,2)       = imdilate(data(:,:,2),se1) + imdilate(temp,se2);
end

% find motion vectors
blockS          = 15;
hbm             = vision.BlockMatcher('ReferenceFrameSource',...
                'Input port','BlockSize',[blockS blockS],'Overlap',[blockS-1 blockS-1]);
hbm.OutputValue = 'Horizontal and vertical components in complex form';
motion          = step(hbm,data(:,:,1),data(:,:,2));
halphablend     = vision.AlphaBlender;

img12           = step(halphablend,data(:,:,1),data(:,:,2));
motion          = motion - mean(motion(:));

figure;
imagesc(img12)


[X,Y]           = meshgrid(1:5:N,1:5:M);
Vx              = real(motion(1:5:M,1:5:N));
Vy              = imag(motion(1:5:M,1:5:N));

figure;
imagesc(img12)
hold on
quiver(X,Y,Vx,Vy,5)



div = divergence(real(motion),imag(motion));
figure;
imagesc(div);
title('Divergence')


nr     = 9;
rad    = linspace(10,50,nr);
figure;

for ii = 1:nr
    
    h    = fspecial('disk', rad(ii));
    flux = imfilter(div,h,'replicate');
    subplot(3,3,ii) 
    imagesc(flux);
    title(sprintf('Flux , Disk Radius: %.1f',rad(ii)));

    
end

figure;
for ii = 1:nr
    
    h    = fspecial('disk', rad(ii));
    flux = imfilter(div,h,'replicate');
    maxF = max(flux(:));
    
    thresh = 0.7;
    flux(flux < thresh*maxF) = 0;
    subplot(3,3,ii) 
    imagesc(flux);
    title(sprintf('Flux , Disk Radius: %.1f , Threshold: %.1f',rad(ii),thresh));

    
end
figure;mesh(flux)

% 
% 
% 
% figure;
% DisplaySat(fileName,imageType);
% xlim([xCb-radius xCb+radius]) % Long
% ylim([yCb-radius yCb+radius]) % Lat
