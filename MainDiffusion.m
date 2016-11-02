close all;
% clear;

%%
set(0,'defaulttextinterpreter','latex')
dirExp      = 'C:\Users\salmogl\Documents\Data\CB\cb_examples\example2\'; %'./cb_examples/example1/IR/';
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

imNum     = 30;
data      = zeros([size(mTemp), imNum]);
[xCb, yCb, iFrame] = getCbCoor(dirExp,imageType);

% figure;
jj        = 1;
for ii = iFrame-floor(imNum/2):iFrame+ceil(imNum/2)-1 %1 : L
    
    fileName     = [dirName vList(ii).name];
    I            = LoadSat(fileName, imageType);
        
%     subplot(sqrt(imNum),sqrt(imNum),jj);
    DisplaySat(fileName,imageType);
%     xlim([xCb-3 xCb+3]) % Long
%     ylim([yCb-3 yCb+3]) % Lat

    data(:,:,jj) = I;
    jj      = jj + 1;

%     data(:,:,ii) = im2col(I, [blockLength, blockLength], 'Distinct');
end

%%
nx       = 32;
ny       = 32;
nz       = 5;
patches  = get3dPatch(data, nx, ny, nz);


%%
% addpath(genpath('C:/Users/Oryair/OneDrive/Technion/Master/Ronen/Matlab/3D_Questionnaire'));
% addpath(genpath('C:/Users/Oryair/OneDrive/Technion/Master/Ronen/Matlab/Matlab_Utils'));
% addpath('C:\Users\salmogl\Google Drive\Master\MATLAB\3D_Questionnaire');
% addpath('C:\Users\salmogl\Google Drive\Master\MATLAB\Matlab_Utils');

%%
dist         = pdist(patches');

%%
args.eps     = 1e4;%4000;
embedding    = calcEmbedding( dist , args );

%%
idxCb                  = [xCb yCb]; % 35.09 -0.77; 21.35 -0.224];
[patchInCb, patchNoCb] =  getPatchesInCb(idxCb,imNum,nx,ny,nz);


%%
[D1, D2]            = size(patches);
colors              = zeros(1,D2);%1 : D2;
colors(patchInCb)   = 0.5;
fontS               = 15;
figure; 
scatter3(embedding(patchInCb, 1), embedding(patchInCb, 2), embedding(patchInCb, 3), 30, 'r', 'Fill'); 
hold on
scatter3(embedding(patchNoCb, 1), embedding(patchNoCb, 2), embedding(patchNoCb, 3), 30, 0.5*ones(1,3)); 
legend('CB','Not CB')
xlabel('$\phi_1$','FontSize',fontS)
ylabel('$\phi_2$','FontSize',fontS)
zlabel('$\phi_3$','FontSize',fontS)
title(sprintf('Embedding of Patches: %dX%dX%d',nx,ny,nz))

%%
% PCA
[~,~,pc]      = svds(patches,3);
figure; 
scatter3(pc(patchInCb, 1), pc(patchInCb, 2), pc(patchInCb, 3), 30, 'r', 'Fill'); 
hold on
scatter3(pc(patchNoCb, 1), pc(patchNoCb, 2), pc(patchNoCb, 3), 30, 0.5*ones(1,3)); 
legend('CB','Not CB')
xlabel('$PC_1$','FontSize',fontS)
ylabel('$PC_2$','FontSize',fontS)
zlabel('$PC_3$','FontSize',fontS)
title(sprintf('PCA of Patches: %dX%dX%d',nx,ny,nz),'FontSize',fontS)