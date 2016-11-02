function patches = get3dPatch(data,nx, ny, nz)

nPatch  = prod(size(data))/nx*ny*nz; % number of all patches
% patches = zeros(nx*ny*nz,nPatch);    
nzP     = size(data,3)/nz;          
patches = [];

for zz = 1:nzP
    
    ii     = (zz-1)*nz+1;
    temp   = [];
    for jj = 1:nz
        
        temp    = vertcat(temp,im2col(data(:,:,ii), [nx, ny], 'Distinct'));       
        ii      = ii + 1;
        
    end
    
    patches = horzcat(patches,temp);
    
end

aaa(1:2,1:5,4:6) =5*ones(2,5,3);
aaa(3:4,1:5,4:6) =6*ones(2,5,3);
aaa(1:2,6:10,4:6) =7*ones(2,5,3);
aaa(3:4,6:10,4:6) =8*ones(2,5,3);