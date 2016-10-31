close all;
clear;

%%
dirName     = './cb_examples/example1/IR/';
imageType   = 1;
vList       = dir([dirName, '*.gif']);
L           = length(vList);
blockLength = 30;

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
addpath(genpath('C:/Users/Oryair/OneDrive/Technion/Master/Ronen/Matlab/3D_Questionnaire'));
addpath(genpath('C:/Users/Oryair/OneDrive/Technion/Master/Ronen/Matlab/Matlab_Utils'));

%%
[D1, D2, D3] = size(data);


%%
params = SetQuestParamsMain2(ndims(data), false);

%%
[Trees, dual_aff, init_aff, embedding] = RunGenericDimsQuestionnaire(params, data);

%%
figure; scatter3(embedding{1}(:, 1), embedding{1}(:, 2), embedding{1}(:, 3), 100, 1 : D1, 'Fill'); colorbar;
figure; scatter3(embedding{2}(:, 1), embedding{2}(:, 2), embedding{2}(:, 3), 100, 1 : D2, 'Fill'); colorbar;
figure; scatter3(embedding{3}(:, 1), embedding{3}(:, 2), embedding{3}(:, 3), 100, 1 : D3, 'Fill'); colorbar;
