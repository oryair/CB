function [ embedding ] = calcEmbedding( dist , args )

eucDist    = squareform(dist);
eps        = args.eps * median(dist);
aff        = exp(-eucDist.^2 / eps^2);

D          = diag(sum(aff,2));
aff_stoch  = D \ aff;

eigsnum            = 4;
% tic;
[eigvecs, eigvals] = eigs(aff_stoch, eigsnum);
embedding          = eigvecs(:,2:eigsnum) * eigvals(2:eigsnum,2:eigsnum);
% toc;


% tic;
% [eigvecs, eigvals] = eig(aff_stoch);
% toc;
% embedding          = eigvecs(:,2:4) * eigvals(2:4,2:4);

end

