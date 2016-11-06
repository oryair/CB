close all;
clear;

set(0,'defaulttextinterpreter','latex')

%%
dirExp      = 'C:\Users\salmogl\Documents\Data\CB\cb_examples\example2\';
imageType   = 1;

if (imageType)
    dirName     = strcat(dirExp,'IR\');
else
    dirName     = strcat(dirExp,'HRV\');
end

vList       = dir([dirName, '*.gif']);
L           = length(vList);
blockLength = 32;

%%
fileName  = [dirName vList(1).name];
mTemp     = LoadSat(fileName, imageType);
mTemp     = im2col(mTemp, [blockLength, blockLength], 'Distinct');

data      = zeros([size(mTemp), L]);

for ii = 1 : L
    fileName     = [dirName vList(ii).name];
    I            = LoadSat(fileName, imageType);
    data(:,:,ii) = im2col(I, [blockLength, blockLength], 'Distinct');
end

%%
% addpath(genpath('C:/Users/Oryair/OneDrive/Technion/Master/Ronen/Matlab/3D_Questionnaire'));
% addpath(genpath('C:/Users/Oryair/OneDrive/Technion/Master/Ronen/Matlab/Matlab_Utils'));
addpath(genpath('C:\Users\salmogl\Google Drive\Master\MATLAB\3D_Questionnaire'));
addpath(genpath('C:\Users\salmogl\Google Drive\Master\MATLAB\Matlab_Utils'));

%%
[D1, D2, D3] = size(data);


%%
params = SetQuestParamsMain2(ndims(data), false);

%%
[Trees, dual_aff, init_aff, embedding] = RunGenericDimsQuestionnaire(params, data);

%%
[xCb, yCb, iFrame]     = getCbCoor(dirExp,imageType);
[patchInCb, patchNoCb] = getPatchesInCb([xCb yCb],1,blockLength,blockLength,1);
cbFrames               = iFrame-5:iFrame+5;
%%
figure; scatter3(embedding{1}(:, 1), embedding{1}(:, 2), embedding{1}(:, 3), 100, 1 : D1, 'Fill'); colorbar;
title('Questionnare (Axis: patch coordinates)') 

figure; 
scatter3(embedding{2}(patchInCb, 1), embedding{2}(patchInCb, 2), embedding{2}(patchInCb, 3), 30, 'r', 'Fill'); colorbar;
hold on
scatter3(embedding{2}(patchNoCb, 1), embedding{2}(patchNoCb, 2), embedding{2}(patchNoCb, 3), 30, 0.5*ones(1,3)); colorbar;
title('Questionnare (Axis: patches)') 
legend('CB','Not CB')

figure; 
scatter3(embedding{3}(:, 1), embedding{3}(:, 2), embedding{3}(:, 3), 100, 1 : D3); colorbar;
hold on
scatter3(embedding{3}(cbFrames, 1), embedding{3}(cbFrames, 2), embedding{3}(cbFrames, 3), 100, 'r','Fill'); colorbar;
title('Questionnare (Axis: frames)') 
legend('Not CB','CB')
