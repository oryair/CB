function I = DisplaySat(file, ImageType)

% ImageType = 0; % 0 = HRV, 1 = IR
I         = im2double(imread(file));
% I         = imresize(I, 0.5);
lon       = linspace(15,58,1024);
lat       = linspace(38,-9,1024);


if ImageType == 0 % HRV
    imagesc(lon, lat, I / (max(I(:)))); title('\bfHRV');
else % IR
    %-- Cloud ceiling Temperature [celsius]:
    imagesc(lon, lat, 0.5 * 255 * I - 80); title('\bfIR');
end

title(file, 'Interpreter', 'None');
xlabel('Longitude'); ylabel('Latitude');
colormap('jet');     colorbar;axis image
axis xy;             grid on



end