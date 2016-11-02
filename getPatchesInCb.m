function [patchInCb, patchNoCb] =  getPatchesInCb(idxCb,imNum,nx,ny,nz)

lon      = linspace(15,58,1024);
lat      = linspace(38,-9,1024);
[LON,LAT]= meshgrid(lon,lat);
LON      = repmat(LON,[1 1 imNum]);
LAT      = repmat(LAT,[1 1 imNum]);
lonPatch = get3dPatch(LON, nx, ny, nz);
latPatch = get3dPatch(LAT, nx, ny, nz);
radCb    = 0.75; % [deg]

patchInCb = zeros(size(lonPatch));
for ii = 1:size(idxCb,1)
    
        patchInCb((lonPatch > idxCb(ii,1) - radCb) & (lonPatch < idxCb(ii,1) + radCb) & ...
                  (latPatch > idxCb(ii,2) - radCb) & (latPatch < idxCb(ii,2) + radCb)) = 1;
      
end

% debug
% recIm = zeros(1024,1024,imNum);
for  kk = 1:imNum/nz
    for zz = 1:nz;
        jj            = (zz-1)*nx*ny + 1;
        mm            = (kk-1)*1024^2/(nx*ny) + 1;
        curI          = patchInCb(jj:jj+nx*ny-1,mm:mm+1024^2/(nx*ny)-1);
        recIm         = col2im(curI,[nx ny],[1024 1024],'distinct');
        figure;
        imshow(recIm);
    end
end


[~,patchInCb]        = ind2sub(size(patchInCb),find(patchInCb));
patchInCb            = unique(patchInCb);
patchNoCb            = ones(1,size(latPatch,2));
patchNoCb(patchInCb) = 0;
patchNoCb            = find(patchNoCb);

end