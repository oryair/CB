% close all;
% clear;

% fileName1  = './cb_examples/example1/IR/20110224_0000.gif';
% fileName2  = './cb_examples/example1/IR/20110224_0100.gif';
% imageType = 1;
% 
% I1 = LoadSat(fileName1, imageType);
% I2 = LoadSat(fileName2, imageType);

%%
dirName   = 'C:\Users\Oryair\Desktop\Workarea\Alon Amar\data\cb_examples\example2\IR\';
% dirName   = './cb_examples/example2/IR/';
imageType = 1;
vList     = dir([dirName, '*.gif']);
L         = length(vList);

figure;
for ii = 1 : L
    fileName = [dirName vList(ii).name];
    DisplaySat(fileName, imageType);
    drawnow;
%     keyboard;
end

%%
figure;
fileName = [dirName vList(49).name];
I        = LoadSat(fileName, imageType);

mC = im2col(I, [30, 30], 'Distinct');