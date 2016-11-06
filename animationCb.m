close all;
% clear;

%%
set(0,'defaulttextinterpreter','latex')
dirExp      = 'C:\Users\salmogl\Documents\Data\CB\cb_examples\example8\'; %example8
imageType   = 1;

if (imageType)
    dirName     = strcat(dirExp,'IR\');
else
    dirName     = strcat(dirExp,'HRV\');
end

vList       = dir([dirName, '*.gif']);
L           = length(vList);
blockLength = 30;

%%
fileName  = [dirName vList(1).name];
mTemp     = LoadSat(fileName, imageType);
% mTemp     = im2col(mTemp, [blockLength, blockLength], 'Distinct');

imNum               = 30;
data                = zeros([size(mTemp), imNum]);
[xCb, yCb, iFrame]  = getCbCoor(dirExp,imageType);
fileName            = [dirName vList(iFrame).name];

figure;
figure('units','normalized','outerposition',[0 0 1 1])
set(gca, 'nextplot','replacechildren');

subplot(121)
DisplaySat(fileName,imageType);
xlim([xCb-3 xCb+3]) % Long
ylim([yCb-3 yCb+3]) % Lat

for ii = iFrame-floor(imNum/2):iFrame+ceil(imNum/2)-1 %1 : L
    
    fileName     = [dirName vList(ii).name];
%     I            = LoadSat(fileName, imageType);
     

    subplot(122)
    DisplaySat(fileName,imageType);
    xlim([xCb-3 xCb+3]) % Long
    ylim([yCb-3 yCb+3]) % Lat
    
    
    pause(0.007);


end

