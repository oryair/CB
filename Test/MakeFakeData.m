close all;
clear;

D = 1024;
I = zeros(D);

vX = linspace(15,58,1024);
vY = linspace(38,-9,1024);

x = 400;
y = 600;

SE = strel('Disk', 300);

I(y, x) = 255;
I       = imdilate(I, SE);
I       = uint8(I + 50 * randn(size(I)));


date  = '20171213_';
vTime = (0 : (12*4)) * 15 / 60;

for ii = 0 : 23
    for jj = 0 : 15 : 45
        fileName = [date, num2str(ii, '%02d'), num2str(jj, '%02d'), '.gif'];
        imwrite(I, fileName, 'gif');
    end
end

        

figure; imagesc(I);


