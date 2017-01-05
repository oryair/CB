
close all;
clear;

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
%     DisplaySat(fileName,imageType);
%     xlim([xCb-3 xCb+3]) % Long
%     ylim([yCb-3 yCb+3]) % Lat

    data(:,:,jj) = I;
    jj      = jj + 1;

%     data(:,:,ii) = im2col(I, [blockLength, blockLength], 'Distinct');
end

datn  = data + abs(min(data(:))); 
datn  = uint8(255*datn / abs(max(datn(:))));

% videoReader = vision.VideoFileReader('viptraffic.avi','ImageColorSpace','Intensity','VideoOutputDataType','uint8');
converter = vision.ImageDataTypeConverter; 
opticalFlow = vision.OpticalFlow('ReferenceFrameDelay', 1);
opticalFlow.OutputValue = 'Horizontal and vertical components in complex form';
% shapeInserter = vision.ShapeInserter('Shape','Lines','BorderColor','Custom', 'CustomBorderColor', 255);
% videoPlayer = vision.VideoPlayer('Name','Motion Vector');
%Convert the image to single precision, then compute optical flow for the video. Generate coordinate points and draw lines to indicate flow. Display results.

radius    = 25;
lon       = linspace(15,58,1024);
lat       = linspace(38,-9,1024);


figure;
imagesc(lon,lat,0.5 * 255 * data(:,:,round(imNum/2)) - 80);
colormap('jet'); colorbar; axis image
axis xy;             grid on
xlim([xCb-radius xCb+radius]) % Long
ylim([yCb-radius yCb+radius]) % Lat

opticFlowLK = opticalFlowLK('NoiseThreshold',0.05*0.009);

for  ii = imNum/2-5:imNum/2+5
    %frame = step(videoReader);
    im   = step(converter, datn(:,:,ii));
    of   = step(opticalFlow, im);
    flow = estimateFlow(opticFlowLK,datn(:,:,ii));
    
    [LON,LAT] = meshgrid(lon,lat);
    figure;
%     imagesc(lon,lat,0.5 * 255 * abs(of) - 80);
    imagesc(lon,lat,0.5 * 255 * (data(:,:,ii)) - 80);
    colormap('jet'); colorbar; axis image
    axis xy; grid on
    hold on
    quiver(LON,LAT,flow.Vx,flow.Vy,5)
%     plot(flow)%,'DecimationFactor',[5 5],'ScaleFactor',10)
    axis xy
    hold off

    
end
%Close the video reader and player

% release(videoPlayer);
% release(videoReader);


