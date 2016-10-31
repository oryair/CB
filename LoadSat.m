function I = LoadSat(file, ImageType)

% ImageType = 0; % 0 = HRV, 1 = IR
I         = im2double(imread(file));

if ImageType == 0 % HRV
    I = I / max(I(:));
else % IR
    %-- Cloud ceiling Temperature [celsius]:
    I = 0.5 * 255 * I - 80;
end

end